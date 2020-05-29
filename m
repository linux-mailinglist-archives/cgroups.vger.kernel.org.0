Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7EC11E8A7F
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2020 23:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgE2Vzi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 May 2020 17:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbgE2Vzi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 May 2020 17:55:38 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC25C03E969
        for <cgroups@vger.kernel.org>; Fri, 29 May 2020 14:55:37 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k26so5617622wmi.4
        for <cgroups@vger.kernel.org>; Fri, 29 May 2020 14:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=y+7fPyOVJN5kEZ9dPieR6MlsnghgeDslNqLeQyzk6T0=;
        b=WZeC7eO7/F1ZaHD2HPukUdjFIz2gU316B+8AUCkZ3RKsm7iLEROxDs+nbuAmSb/M1D
         oto7q3ImBObrsf7Z8ZjIa2xJvNFfpmhYKUXEMNdbGPul2Odv8xHsR0jxFRbs75pFsx8s
         tEBmiGdLzbVZNYQ5xTX0vEWNkGPpXNroUaoy77ja1l5tGYab04onKEOIRN3Mi46GrMtQ
         SetD/TtpId/Ilf7VGL1u8VPwxrB29EEl3tywWnAl0i+PVtPjDP3lxNZ07IpbuOUE4a55
         fiblyxy3HtslcCuCq66nOo+R7FDVhxyx46HZvQ+KZjC/3rkGtvP+LfVqOmpJFfg5Znu7
         Qzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=y+7fPyOVJN5kEZ9dPieR6MlsnghgeDslNqLeQyzk6T0=;
        b=pitakoWAkPkQOK7SkJEO5Tqf9JEZn0rDF3Ms0GuXyxM2M+AdIbLtLcOCJIQq8mzKYY
         woIHcgn53xoahLukIK9ONEBXho3q+HVBa8vFSzE64d+mH2J/vEqNe2Kb5LPZl8kV8ZUE
         7vFIvowGOlCcKiicECY7P4qbmY+fssCWAIwEiTK693rXGg5WiyouCkce3hNxlZN8z9nd
         iu7QcjvHkz0gPZyrT8kgccU4IDuWxjVoXUHFEEbgvzvzSFt57tZjikMb7SPqvFjFUiXU
         ZWvRgMVLpdtBTQQpWQlxKztdsk/HvF88giug542sX5uvFTa8BayW9/4DDMcqYFWk74XB
         Y4kg==
X-Gm-Message-State: AOAM532q6mzscV/G8iKTO25GkTHmuDRNTUOnCwbu+SDwHwy0hbHgTSaY
        ZDIJm7PGFDrck+LWsK+nYmMKrw==
X-Google-Smtp-Source: ABdhPJwebDU0toeDqVExcoUsOjyNPjev/ummN9l/P8IRsg1/RBgPJu0TE/gEy3JksZSZdsnGz7qe6A==
X-Received: by 2002:a05:600c:3cf:: with SMTP id z15mr10058213wmd.24.1590789335789;
        Fri, 29 May 2020 14:55:35 -0700 (PDT)
Received: from ?IPv6:2001:16b8:4826:7300:a436:5e5d:3e25:d8b3? ([2001:16b8:4826:7300:a436:5e5d:3e25:d8b3])
        by smtp.gmail.com with ESMTPSA id t14sm5080616wri.7.2020.05.29.14.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 14:55:35 -0700 (PDT)
Subject: Re: [PATCH 0/4] cleanup for blk-wbt and blk-throttle
To:     tj@kernel.org, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org
References: <20200508220015.11528-1-guoqing.jiang@cloud.ionos.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <f308bc7f-083a-d0f3-aad2-b353c241dbde@cloud.ionos.com>
Date:   Fri, 29 May 2020 23:55:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200508220015.11528-1-guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Gently ping.

On 5/9/20 12:00 AM, Guoqing Jiang wrote:
> Hi,
>
> Find some functions can be removed since there is no caller of them when
> read the code.
>
> Thanks,
> Guoqing
>
> Guoqing Jiang (4):
>    blk-throttle: remove blk_throtl_drain
>    blk-throttle: remove tg_drain_bios
>    blk-wbt: remove wbt_update_limits
>    blk-wbt: rename __wbt_update_limits to wbt_update_limits
>
>   block/blk-throttle.c | 63 --------------------------------------------
>   block/blk-wbt.c      | 16 +++--------
>   block/blk-wbt.h      |  4 ---
>   block/blk.h          |  2 --
>   4 files changed, 4 insertions(+), 81 deletions(-)
>

