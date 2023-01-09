Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA340661E02
	for <lists+cgroups@lfdr.de>; Mon,  9 Jan 2023 05:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjAIEvc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 8 Jan 2023 23:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbjAIEv2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 8 Jan 2023 23:51:28 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BCD64E4
        for <cgroups@vger.kernel.org>; Sun,  8 Jan 2023 20:51:27 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1322d768ba7so7582579fac.5
        for <cgroups@vger.kernel.org>; Sun, 08 Jan 2023 20:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RGBJdUhLvGpLg0IkWbTVUsItZJ0ILG7BPRGCq35WdVY=;
        b=AkViJTiBNYMerAGZgvQiB/d9Sk2tEL+U6ZHX1c7qEcgGydFKOKfGGYbp0cDbIlNHHq
         O4xD0BkD6+/NUwVbl6AbHaFP+XvC2LNykVXrvNoFTqc35qDrvt2zW9B0P0g+n5+c8fpM
         6blBcecNYUUV1RT6jr3lUV4DazFS/XGEOUtuUHbU2R0fOMVohZgdf+EEPtRLerlW4hDV
         uvPOHvgtCKrzN9IPBYb2AdHJ860ueT59x3TkfZedpheQ02e8Sdpujelf+vnI74AioOvT
         K37OZuLnM+BJxHRc1cmeSFiyn8V/EbQxu/tFI5dGyMhmWxqUB1U+DsQaHqJPDvHZrAPF
         z4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RGBJdUhLvGpLg0IkWbTVUsItZJ0ILG7BPRGCq35WdVY=;
        b=1cUkxMiy5ImHaF8h3Lu6hvDaLzsR/Ej2mzPuagxWw2kaajpJv9UvP51SEZpy5TLX63
         CaHvppLp0pGGZRoTLnQ3kMD8Dcmomkv5hkxzCSml375oj4ta2PyuaP+dXKy5QihGkhkP
         GbwJZek4DE1pxAiU62HnJAepLoYr++bhniOxYRPi+UCqtjE77vX3vf+ASG68ehlxxKeK
         AM8ahI7Jyr8/riIfw1kBbynSajxgYKmhSep0Oxo6bLc0qQ3ado6vPW/bLCheI9yuoIZa
         YmT6K0nRhZKmAjDAZG8RSoyD2GqsjhWQpV402ZpRrMMNuozG37G0fl2V8JUZ0Or62lKg
         ZQNw==
X-Gm-Message-State: AFqh2krhonw6Vi6HzTfCqT7ZD3GJMEz6ArV7/ZDFN/RzJjIhDI7mWhcQ
        XkgQgpZn2LeetraTGk41C0IPu40AfrzZ9Tjkksg=
X-Google-Smtp-Source: AMrXdXs9Pe4VZuN7oYRSzbX7UlnzH49IEYe+u8dXKi9id6wZiyiqZeZSwan2RRBf0koxM+ZywAZ7GW97ZUGI7J7bzxk=
X-Received: by 2002:a05:6870:ee10:b0:14f:b933:fd54 with SMTP id
 ga16-20020a056870ee1000b0014fb933fd54mr4720361oab.84.1673239886159; Sun, 08
 Jan 2023 20:51:26 -0800 (PST)
MIME-Version: 1.0
Sender: skerlwindy2827@gmail.com
Received: by 2002:a05:6850:d456:b0:3dc:ab78:6362 with HTTP; Sun, 8 Jan 2023
 20:51:25 -0800 (PST)
From:   TOM HUDDLESTON <tomhuddleston1jr@gmail.com>
Date:   Mon, 9 Jan 2023 07:51:25 +0300
X-Google-Sender-Auth: DVA64Eca7fyVLhg0nC4JDsz0KUQ
Message-ID: <CANz9-WSETgehcyVtXeWqx1Ghwjaam2tDh2E+OrtKj5XcG65i9A@mail.gmail.com>
Subject: Ich habe Ihnen bis zu 3 E-Mails gesendet
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

--=20
Ich habe Ihnen 3 E-Mails bez=C3=BCglich Ihrer Spende gesendet, aber keine
Antwort. Bitte melden Sie sich mit Ihrem vollst=C3=A4ndigen Namen und Ihrer
WhatsApp-Nummer bei mir, um dieses Geld an Sie weiterzuleiten.

Ignorieren Sie diese Nachricht nicht, wenn Sie sie in Ihrem Spam oder
Posteingang finden

Gr=C3=BC=C3=9Fe
Tom Huddleston
