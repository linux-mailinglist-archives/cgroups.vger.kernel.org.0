Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E295784AE
	for <lists+cgroups@lfdr.de>; Mon, 18 Jul 2022 16:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbiGROE1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Jul 2022 10:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbiGROE0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Jul 2022 10:04:26 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F59DF2A
        for <cgroups@vger.kernel.org>; Mon, 18 Jul 2022 07:04:25 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id n18so19525257lfq.1
        for <cgroups@vger.kernel.org>; Mon, 18 Jul 2022 07:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=kg4ZRwuPTKpxnftYAjO1ZW7HIB76yWlSlnTpt9AQipg=;
        b=gyYn+VrZrJZ/d4sVQU2/XAovn5ko6nitgHSMo9CBlts+AF1HGJykleFKDgrtPN09Hq
         W7s2bx/2iw0/o62cMfqYuHmdlCJ4kFOBLLWEv55p5EDzKAHkNqH6uITbmIX1yqtmhSLU
         Moqhz8WhB76gRdncAdjFUxg7NaQobBGIggjy1tceoDT0AWlKAUFpaKxUzKurVh9+zOQl
         EkUriN9qrfdwAu9TbpX9ipM4A1iJcpXGF6rnPMOqjkz0U75+1rFWs7uP2gpE9jNgOo2U
         PEYuCPN/c0tsQsUljN1C5kIiT9v1di5z8Cx9ac9vN2MS6jq75BPnv35lWjc5f9hbTua0
         nTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=kg4ZRwuPTKpxnftYAjO1ZW7HIB76yWlSlnTpt9AQipg=;
        b=Sq5GMdWyJc0DuN1xYvE0LrMHbZItGvpnElDDR+aFJnjzWlT8nrwrUiRBNL+9WpQ5Ry
         kR4XBPzWm4PFNGmXUaUBG3yyDGun1xMMGM6HgzR/uCjnM+sNqquvFto9H0EvMCZWGQ1y
         kuRGwwvDHJPFywpBJDlMawCda4l9IpDEkOI3L0ZEM24YMUMMczakAgMNWdL5sU3ayyxp
         mzTuwwsq1zNDLJFJfI84EnZQrJu89klXelobW4egbdyfx381/JBwmKmgzIGYCc6websv
         /afgtIzXyHlFmoeW+9QSymIZGh+hZNg7itFr4ihrZpsZx0on04gUcGh9b3qzDx+HJRFL
         +/YQ==
X-Gm-Message-State: AJIora89VZTaJARFVOuP+LExMYi/HW3NxArbU/txuMUYn3OtYx8AvD8D
        ydjXIBbcXXma8IbyCX5dGXmA7UBnOJAarxkdutw=
X-Google-Smtp-Source: AGRyM1vHe/7sa6is2mtzzKRuXjAviYB6fEO4cdvfcGTq+vrIbyWUbO1uzJ+WuSWQ+e7k2iZcfGAxcgrlCopO+C5gGMk=
X-Received: by 2002:a05:6512:2621:b0:47f:d228:bdeb with SMTP id
 bt33-20020a056512262100b0047fd228bdebmr13984768lfb.121.1658153063748; Mon, 18
 Jul 2022 07:04:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6504:2c7:b0:1d7:bcda:3187 with HTTP; Mon, 18 Jul 2022
 07:04:23 -0700 (PDT)
Reply-To: infodeskuk02@proton.me
From:   Tom Crist <jamesstanleyarcher@gmail.com>
Date:   Mon, 18 Jul 2022 16:04:23 +0200
Message-ID: <CAMpdiV3WkqDvYfcNdvbz1J0uVAym0Gf-sq_e_5MAVThfdTLp6A@mail.gmail.com>
Subject: Re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

--=20
Ich kann Sie nicht direkt telefonisch kontaktieren und muss einen
Notfallvorschlag =C3=BCber Ihren Namen besprechen. Wenden Sie sich an eine
E -Mail: Infodeskuk643@gmail.com,
Infodeskuk02@proton.me
