Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276264F14B5
	for <lists+cgroups@lfdr.de>; Mon,  4 Apr 2022 14:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244265AbiDDM10 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Apr 2022 08:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiDDM10 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Apr 2022 08:27:26 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B6E3B56D
        for <cgroups@vger.kernel.org>; Mon,  4 Apr 2022 05:25:30 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id q26so3223549edc.7
        for <cgroups@vger.kernel.org>; Mon, 04 Apr 2022 05:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:content-language:from
         :subject:content-transfer-encoding;
        bh=SYa0Jf1JBf+hKoQ5XoVsa6vRKIe3ItAJl54XdHPKelM=;
        b=VqoMexCOiLjUKiVT1lWCXyjxxD4aXjBjLcBbFqK72xiu3O4VU4/8rVIhnwoaLv7omC
         pwIRFAwlYL9tENq8rzVmlAW0OifAyBOKSlPEW6iKXLFJqQEmHXj0oT2AEnJpsNrq/hl6
         eAyo0xSviPluO9T3fhM1pI3zyvbttdRiIsDVfxH/Iyge40abdhGgt5A0vkkbYGcOVf3p
         FhCaYpOke/1wMN71OO4lna7IqSNFFFE+OYoJYTaL8w5eXmhaqI6ze7eT3qbEqw9QYSGD
         ih0KW7/qHWIGkXO2s2ZICXD1d0ChI41RWg+HN/eaNxT7gsUL+nntqy5DP+v1J3cnvbML
         YTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to
         :content-language:from:subject:content-transfer-encoding;
        bh=SYa0Jf1JBf+hKoQ5XoVsa6vRKIe3ItAJl54XdHPKelM=;
        b=ywMd544AzV/hBzuIMokc8hr9a8MFZoSmDLpzD2T8iiIahbQXfrzvBoiP/fyTiuMEPT
         MWavgVzIBuOVqcd3vB0jkpMyNkmOZiBOod89aNWjg1K8wd2bXIg7bHUvsDhVX7pGWryk
         gbMB1tgFmGH7Pg1LZd4d2Mx/IhLLEpTL7thzNaxQ0T6SWbsegFErLvtlNacoE+mm2vJ3
         UiXzo0AcrNCA47ileSmAojlSTt8Dzmu1iPHalcjnRHKEMMoQHWwMaqNzEvXSRX46c3Sw
         cCJN980kyZdvyDXmvGWU80SPtDUPsWlpeh6B/dnDXEsvHv2UazrOK/bnhWmS/Thqo9TT
         +O8w==
X-Gm-Message-State: AOAM532ecX/JOd6+j4dPEP1rdwB1z/z6Gf44RXe0QbyRKSAgs3pjzgCC
        bQtZQRiy+ZVbGQSjhFgftrftpRcXzr4=
X-Google-Smtp-Source: ABdhPJxoEypYa6IxI0zbWHzFGZJ7FEUWYaJntxezZ8ozRo2oy7Rz1Sp6AvbYjsrZPv1oTCKabKNASg==
X-Received: by 2002:a05:6402:350c:b0:419:3cb8:b714 with SMTP id b12-20020a056402350c00b004193cb8b714mr32592849edd.297.1649075128889;
        Mon, 04 Apr 2022 05:25:28 -0700 (PDT)
Received: from [192.168.115.146] (55d49e10.access.ecotel.net. [85.212.158.16])
        by smtp.gmail.com with ESMTPSA id i11-20020a05640242cb00b0041922d3ce3bsm5321026edc.26.2022.04.04.05.25.28
        for <cgroups@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 05:25:28 -0700 (PDT)
Message-ID: <0174490d-8679-3885-df31-e9f6c1e7205b@gmail.com>
Date:   Mon, 4 Apr 2022 14:25:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
To:     cgroups mailinglist <cgroups@vger.kernel.org>
Content-Language: en-GB
From:   "R. Diez" <rdiez1999@gmail.com>
Subject: Wrapper to run a command in a temporary cgroup
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi all:

I am looking for a wrapper script like this:

run-on-temporary-cgroup.sh cmd arg1 ... argn.

The tool should create a temporary cgroup, run the process inside, and return the same exit code as the user command.

I may want to limit the amount of memory the cgroup is allowed to consume. But more importantly, I want the tool to return when all processes in the cgroup (the user command an any children) have already terminated. This is apparently not so easy to achieve without cgroups.

Those requirements are similar to what systemd-run does, but I need an alternative which does not depend on systemd.

Even if you have systemd, systemd-run is rather convenient, but it is somewhat heavy weight and it has issues with some signals (like SIGTERM), and with escaping/quoting, depending on the mode (--scope vs --wait).

If there is no such a tool, can someone give me some hints on how to implement one? Is it possible in Shell or Perl? Or do I need to reach to C / C++? Is there anything similar I could take as basis?

Apologies if this is not the right mailing list. I could not find anywhere else to ask about cgroups matters.

Regards,
   rdiez
