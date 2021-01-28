Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584A3307832
	for <lists+cgroups@lfdr.de>; Thu, 28 Jan 2021 15:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhA1Oeo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Jan 2021 09:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbhA1Oef (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Jan 2021 09:34:35 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB266C061573
        for <cgroups@vger.kernel.org>; Thu, 28 Jan 2021 06:33:54 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id m6so4108017pfk.1
        for <cgroups@vger.kernel.org>; Thu, 28 Jan 2021 06:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3UJyCYyHELMaW+UVSUKIODWe8UUnEGgoP936EHMWBTE=;
        b=s/8G0pIfrzxemzeiVD4GkxI82+AzGvnsibV4H6ZREvhKAErR0KW0yF6f6G5MIp+ODk
         ABEm1aKAvUVJgyz+u6grfty+wsKgHlPEw11ngoZfP6Xemg19u5GNEPM6fah1KAQB7Sp8
         oXAPsFAqF0AWwrNEV7DNiL/RuDSPjd/SkiPhVdCOXPAq+cdWlAuvZo1m+CoqvVT5fFkE
         +mxqzgsqUuuzNWeUp+7zOWKQCn5MzMa/cB6yN6H8uCRA+ZbZJy/6AD2aBZO36uz/PT8z
         ja08dRmsk+qBPTSyDcOEuhxrz0M3eWb2dBdwGHM6HE/P84WBdVfjsW8BlI+NQU3rraut
         Z93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3UJyCYyHELMaW+UVSUKIODWe8UUnEGgoP936EHMWBTE=;
        b=Dz+dQ5RKXkCRLsi/zFByMiTiFIre6e673d6ABtFNRK7NEDh0BLiDuJpJEMzeguc0dk
         v3isS8JMhjUiHYYNKubduNwyhN10AWEyAIexd0fBce+IquSlJUqLXJ+lpQwX22NJP8LE
         j8F+fEPs+Ur7q+JXz2Gap2kasLkMQJ8ZQZ8owJV0L43EhKrK7nQn0EHwbLf6XKZUYaGm
         xiOySrLaOdX7jwArAK0rlIPqi87XZza4npvqwCGNY3iUz5ZAJjLG23DksDmHBM0mSe4r
         gvfN0Mkq4wwxLh2xEEdw/IaXre3Vt/++5OjINiPAOJOFiXXhxcvbS+USOvlmTglFMr1m
         fU2A==
X-Gm-Message-State: AOAM533s4bmOYzRYYL/FmhXWz2SoXwzCEr3ihJ5s6cYq5QlCm2WtVaR9
        eIxzQeWZtXTgUAr7WEHWzjL4Rg==
X-Google-Smtp-Source: ABdhPJxF6U0Qzrc8Am006a3Fus+0a0hD/R4ejx1kyG1ZkdEuhQ/QEtJnyhwAAJwDlgcfuFPqTdCl1g==
X-Received: by 2002:a62:ee09:0:b029:1c0:ba8c:fcea with SMTP id e9-20020a62ee090000b02901c0ba8cfceamr15832892pfi.7.1611844434516;
        Thu, 28 Jan 2021 06:33:54 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id 130sm6178975pfb.92.2021.01.28.06.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 06:33:53 -0800 (PST)
Subject: Re: [PATCH] blk-cgroup: Remove obsolete macro
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <2d053708b596fe148c1d9e63a97117c150a0004a.1611818240.git.baolin.wang@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fd20b274-2fdc-7046-6571-d11e0a8cf0c4@kernel.dk>
Date:   Thu, 28 Jan 2021 07:33:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2d053708b596fe148c1d9e63a97117c150a0004a.1611818240.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 1/28/21 12:18 AM, Baolin Wang wrote:
> Remove the obsolete 'MAX_KEY_LEN' macro.

Applied, thanks.

-- 
Jens Axboe

