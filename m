Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5725854E1
	for <lists+cgroups@lfdr.de>; Fri, 29 Jul 2022 20:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238520AbiG2SDO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 Jul 2022 14:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238452AbiG2SDO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 Jul 2022 14:03:14 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEBD89AAB
        for <cgroups@vger.kernel.org>; Fri, 29 Jul 2022 11:03:13 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id sz17so9835794ejc.9
        for <cgroups@vger.kernel.org>; Fri, 29 Jul 2022 11:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=u8iIPCrB2/Zj30+SRdOf/V1gQLNWtZ/3UrBy0y8moMk=;
        b=dHd7a3uDee1Nmmqcl7OcYOmR85sIgLsZb+1NRJuhxb0tDfZLFJKzUgW/PkI38Llu3o
         //o/H2Y9GcbW4nZLxkyg9moMIpfQfdPg6rfuTCeHB0Y3vCfnmQ+aKK5pcVqXcGjviG4A
         pun1uBPvHBqYaN3XIVibdI1Hinpb6d2r1e7DxWGUiTIu4ESpNZFJ/nJrphQaqHP1guBY
         zxC0fvWE6U9nY5QVoc5w1Ol4tB7hMx2MgOoe3DQA/elL5Pu78iSjZnIri3aaRIgdHsWc
         OIN8uaNpNJaApr1JvMxsADmkCM2F7614P6YDaSYzcpqhacjz7iuIhKZfDasVPOb1Arjv
         Ox4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=u8iIPCrB2/Zj30+SRdOf/V1gQLNWtZ/3UrBy0y8moMk=;
        b=aysZiIjGBLMLxXfgT+p6q81pr/drJVr/QNfJhNs1Cr7ULqKi7Wf3ZJEu8muq4SLn9x
         qxTyhCPk8U1X97L5N5L6UEk2xJc4xV9zQ/NgF3sD0D5MAZFqWA72CravXvRxrvIJbdjZ
         nPxidevulrTuxtDa8Pn1d3FGb04++QYREXOS4h+AwXx4l3x/qcCJi9H5eBGfZcbBvULZ
         17/x4fMypzNShlBa37Yw4fPtdfqr+8aT6C6e4ddzac/zP1RT/AV6xAkwX70Vvoe0U0zC
         I2R0ERvjv0Kkqt7NfP7kAbwjAcG2HPVOyHHR6j8R/RvY1Jp99jOO+UZP0UGKKBgRvVvY
         ZFyQ==
X-Gm-Message-State: AJIora9gV9DBAg8itziDnTaamxJ6dcsq+f9ybwfvLvrVrIKWqSUVoJoC
        zVcw8vMM72XVBNIw/WBIwbiLtMqQq+dCrXausc0=
X-Google-Smtp-Source: AGRyM1tFP5G2Ww1mJUxSlHPO63RmTcTQpnttQQNwKI4sUgw2KSYK5byws0Kx7INchoHH//XIIo32n66c9A1fePdPxb8=
X-Received: by 2002:a17:907:2c6b:b0:72b:2eb9:6673 with SMTP id
 ib11-20020a1709072c6b00b0072b2eb96673mr3759165ejc.71.1659117791893; Fri, 29
 Jul 2022 11:03:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a98:8810:0:b0:179:ef63:59c7 with HTTP; Fri, 29 Jul 2022
 11:03:11 -0700 (PDT)
Reply-To: infodeskuk02@proton.me
From:   Tom Christ <tc6592301@gmail.com>
Date:   Fri, 29 Jul 2022 20:03:11 +0200
Message-ID: <CABajrGAvExOqxqgASxi5jO1PFRxjAnWzxZ6QwSd4DjgjGq6LqQ@mail.gmail.com>
Subject: Re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

--=20
Sie haben eine Spende, ich habe die Amerika-Lotterie im Wert von 40
Millionen US-Dollar in Amerika gewonnen und beschlossen, einen Teil
davon an f=C3=BCnf gl=C3=BCckliche Menschen und Wohlt=C3=A4tigkeitsorganisa=
tionen in
Erinnerung an meine verstorbene Frau zu spenden, die an Krebs starb.
Kontaktieren Sie mich f=C3=BCr weitere Informationen unter:
infodeskuk643@gmail.com, infodeskuk02@proton.me
