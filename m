Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A614033CA
	for <lists+cgroups@lfdr.de>; Wed,  8 Sep 2021 07:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238723AbhIHFaa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Sep 2021 01:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237726AbhIHFa3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Sep 2021 01:30:29 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F30C061575;
        Tue,  7 Sep 2021 22:29:22 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d18so569216pll.11;
        Tue, 07 Sep 2021 22:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iD9+GT39aksQJ8UeFhirJAMKV3nyN4Kl41ljs81BeAQ=;
        b=fmHJ9TCvMYR155Ey0xmhEA8+GUH+8RWGwTLNvNo3adb/G+kkdBQt003sNOw0RYlz1T
         WVueDkaHjh0B1wi+x9HoykljOypMHA1ERQU36MhnKhG4RmAaq7CEi4+qDJm2vREq+dHJ
         uJFyRsvCzaCMr+HUciciZBZx4imn7nWoLUou9pnFpt6ZllukebteZwuwqGM5zu0ciUM1
         4hc129eckFug/Kb8i1MtqlFser48H/AYemzCFeSsn0lKxidw8eeFCfabkmLavY0ZIoyq
         nApqxwo3s2+EAXfdHYKwNN+PkYtJ5Bjmq622ReanNBMFWFt/7yNiIM1++eVn7oPuGPIt
         vAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iD9+GT39aksQJ8UeFhirJAMKV3nyN4Kl41ljs81BeAQ=;
        b=glnO5opFf06e91FlGSXJJd4YdxCkJasA6tkz9SNrGKSXPeGivKU8X7vHjP4WhtsZcx
         nL34ArP9KIiCaziKfrZ0V2zmSdNlBJoEaeAKfixziSI8NRTWLezlPEmoaez2O7edGw/6
         PgeiIyaknT1fnMIr3KZHNIPPZvzywuXr3lxTFvCqkAt8LJ6NDQwYjjhAv7yfk9Zf7i1K
         GUKJ+s9L9gAh9zi6zr0rhpBIBta6txydFoOzHQoo6i+Ja8GPXw58cPcemJkcCiDjOkPg
         vpFXUfn/Fx5h9l2AHvOYOkNPFi4S71tAXFXUgzLVhayAGGYaVxvTMpaq1/A0FMUOvCid
         xTyw==
X-Gm-Message-State: AOAM5334kIhm3K3+a8P6B0A2oX6iKt53GWe55xSXtegZab66OWtFHKoU
        HU7Ee42G2aBeFlQySF0IlJaVp3tKqATs9w==
X-Google-Smtp-Source: ABdhPJyRK562CkBY8amUR/oXjhr2ATqe0r+SZL822RSZLKMNrS1f+2X7nHby2skFhGbZWpFlcZmTzg==
X-Received: by 2002:a17:903:11c5:b0:138:ce68:68b6 with SMTP id q5-20020a17090311c500b00138ce6868b6mr1666609plh.35.1631078961770;
        Tue, 07 Sep 2021 22:29:21 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.115])
        by smtp.gmail.com with ESMTPSA id c4sm724463pji.51.2021.09.07.22.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 22:29:21 -0700 (PDT)
Subject: Re: [PATCH v2] misc_cgroup: use a counter to count the number of
 failures
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, vipinsh@google.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <a09f381462b1ce9c506a22713b998e21b459f7e9.1628899295.git.brookxu@tencent.com>
 <20210824164423.GA11859@blackbody.suse.cz> <YSVDwc/1sEmXdOK9@slm.duckdns.org>
 <4ed67493-e595-e002-69f9-1f53662ba189@gmail.com>
 <20210826112954.GD4520@blackbody.suse.cz>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <49057879-92a9-958a-ac30-057ceabd1b7f@gmail.com>
Date:   Wed, 8 Sep 2021 13:29:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210826112954.GD4520@blackbody.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi all:

I have sentout misc_cgroup events and events.local related patches.
I want to make corresponding changes to pids cgroup by the way. Do
you think it is ok?

Thanks.
