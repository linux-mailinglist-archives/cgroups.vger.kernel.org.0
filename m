Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32C263FD99
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 02:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiLBBWn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Dec 2022 20:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiLBBWm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Dec 2022 20:22:42 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA4E1836C
        for <cgroups@vger.kernel.org>; Thu,  1 Dec 2022 17:22:40 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id q12so3517127pfn.10
        for <cgroups@vger.kernel.org>; Thu, 01 Dec 2022 17:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ha7o0eCHmk2nS/stJvaRFac3CxHDSLDcs+LGCRqIPBY=;
        b=BuUEFSdIuuRDAjVFKVAhHELsh2BTyw5NoWSVDMZq1DGpduTVgVQpO+7R5WrmoIx13M
         M17M+w1VUbCDiexAf14moFi1WiPv5byymNaQeBzbnNxhv7ZEgDDE4rrQ5yrgFdX+5OQk
         SMfw+xxJKUuemgj7vBvIg7ae5dRpRRx63khUXhSoX7VuLzyVPS08OClh9OJtTo2WieSs
         s2eVSCczZxx7r8aGifEn1xk0+06SAwsbh3KN2NuIRxyJmSHmrAsiyOs6B5CdKbo84sx0
         Q8MkiaW+nBe0rxzoIHJnvyn139jE7veJt1/9E1oQBFtsdQHOysYhnyb90VnNvUPxHr/M
         FFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ha7o0eCHmk2nS/stJvaRFac3CxHDSLDcs+LGCRqIPBY=;
        b=dXgXTqqtv5dqrbxmpKtVBRF0i3A+C5cdYyx2lL86B0dgrWlrhQe4ndiiaND2g7xz1J
         E/77usEOvkqQCPbAb6qoJPXggECE1QTXbzjtA6YllxICfAgrySBn/GdPFfPzixwnkQcs
         oBBMrF1iErUWKgVN63Su/x4VkE3v1F9Ac+bWw7R6hTj+JkCWeubyc4DiztuWhHfWBXtq
         1EvjFLPIpCFK/rmCif48lLW+iWjPwK6GUMvfXlTATp+9bTan9uG4d/zKZoCHU2RMrrVT
         lVfB2WGiTDro+hUnn07NjIgCyDFOGLCxo7tgl8LXObhmWxI8IOiz71yKROq3JzD0Q56U
         UgZQ==
X-Gm-Message-State: ANoB5pllj+kWdfw6y7u4nP7oD6Ryi6mgPqMe5HNacdHlCLBkPjeg4i0H
        m/px2kdEZcwz13b/ejHXbqueCA==
X-Google-Smtp-Source: AA0mqf4FCwGn7yMlLHyKAoU/jghlvAvPD8m60OuAPdXHKHaveyDVw1dMsbzIAn55L/JhLaFI6Sd3aQ==
X-Received: by 2002:a62:9409:0:b0:562:e571:3f0e with SMTP id m9-20020a629409000000b00562e5713f0emr52380182pfe.72.1669944159919;
        Thu, 01 Dec 2022 17:22:39 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w64-20020a17090a6bc600b00219025945dcsm5504114pjj.19.2022.12.01.17.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 17:22:39 -0800 (PST)
Message-ID: <7aa9e496-747d-46ae-b250-d504d84af6e5@kernel.dk>
Date:   Thu, 1 Dec 2022 18:22:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH -next] blk-cgroup: Fix some kernel-doc comments
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, tj@kernel.org
Cc:     josef@toxicpanda.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20221202011713.14834-1-yang.lee@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221202011713.14834-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/1/22 6:17 PM, Yang Li wrote:
> Make the description of @gendisk to @disk in blkcg_schedule_throttle()
> to clear the below warnings:
> 
> block/blk-cgroup.c:1850: warning: Function parameter or member 'disk' not described in 'blkcg_schedule_throttle'
> block/blk-cgroup.c:1850: warning: Excess function parameter 'gendisk' description in 'blkcg_schedule_throttle'

Please always include a fixes line:

Fixes: de185b56e8a6 ("blk-cgroup: pass a gendisk to blkcg_schedule_throttle")

-- 
Jens Axboe


