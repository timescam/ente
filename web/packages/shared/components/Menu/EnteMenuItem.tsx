import {
    SpaceBetweenFlex,
    VerticallyCenteredFlex,
} from "@ente/shared/components/Container";
import {
    Box,
    ButtonProps,
    MenuItem,
    Typography,
    TypographyProps,
} from "@mui/material";
import React from "react";
import { CaptionedText } from "../CaptionedText";
import PublicShareSwitch from "../Collections/CollectionShare/publicShare/switch";

interface Iprops {
    onClick: () => void;
    color?: ButtonProps["color"];
    variant?: "primary" | "captioned" | "toggle" | "secondary" | "mini";
    fontWeight?: TypographyProps["fontWeight"];
    startIcon?: React.ReactNode;
    endIcon?: React.ReactNode;
    label?: string;
    subText?: string;
    subIcon?: React.ReactNode;
    checked?: boolean;
    labelComponent?: React.ReactNode;
    disabled?: boolean;
}
export function EnteMenuItem({
    onClick,
    color = "primary",
    startIcon,
    endIcon,
    label,
    subText,
    subIcon,
    checked,
    variant = "primary",
    fontWeight = "bold",
    labelComponent,
    disabled = false,
}: Iprops) {
    const handleButtonClick = () => {
        if (variant === "toggle") {
            return;
        }
        onClick();
    };

    const handleIconClick = () => {
        if (variant !== "toggle") {
            return;
        }
        onClick();
    };

    return (
        <MenuItem
            disabled={disabled}
            onClick={handleButtonClick}
            sx={{
                width: "100%",
                color: (theme) =>
                    variant !== "captioned" && theme.palette[color].main,
                ...(variant !== "secondary" &&
                    variant !== "mini" && {
                        backgroundColor: (theme) => theme.colors.fill.faint,
                    }),
                "&:hover": {
                    backgroundColor: (theme) => theme.colors.fill.faintPressed,
                },
                "& .MuiSvgIcon-root": {
                    fontSize: "20px",
                },
                p: 0,
                borderRadius: "4px",
            }}
        >
            <SpaceBetweenFlex sx={{ pl: "16px", pr: "12px" }}>
                <VerticallyCenteredFlex sx={{ py: "14px" }} gap={"10px"}>
                    {startIcon && startIcon}
                    <Box px={"2px"}>
                        {labelComponent ? (
                            labelComponent
                        ) : variant === "captioned" ? (
                            <CaptionedText
                                color={color}
                                mainText={label}
                                subText={subText}
                                subIcon={subIcon}
                            />
                        ) : variant === "mini" ? (
                            <Typography variant="mini" color="text.muted">
                                {label}
                            </Typography>
                        ) : (
                            <Typography fontWeight={fontWeight}>
                                {label}
                            </Typography>
                        )}
                    </Box>
                </VerticallyCenteredFlex>
                <VerticallyCenteredFlex gap={"4px"}>
                    {endIcon && endIcon}
                    {variant === "toggle" && (
                        <PublicShareSwitch
                            checked={checked}
                            onClick={handleIconClick}
                        />
                    )}
                </VerticallyCenteredFlex>
            </SpaceBetweenFlex>
        </MenuItem>
    );
}
