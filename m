Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7CD3E4F64
	for <lists+cgroups@lfdr.de>; Tue, 10 Aug 2021 00:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbhHIWjr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Aug 2021 18:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234408AbhHIWjr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Aug 2021 18:39:47 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980E2C0613D3;
        Mon,  9 Aug 2021 15:39:26 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id nt11so7069649pjb.2;
        Mon, 09 Aug 2021 15:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+JExG4XECleL3z2Pr60SpUDE5nO3vODyjR9bd8Nc6kY=;
        b=EPq7r4vY5ue8A5iT753KqHjWSDHd03tLblaNLm/9jVWiWmyDqcrRYISFIKWpeS7f6M
         lK7en01wJBobFejcm4bXg/dPl+gkHFzVEZX4yMgHkQBDccJm5P4E3DOaQh9ehgCmKM9/
         GRBPR03vn7t/BavtMLfomKuotxZUt5ucD3RNYD/xLQzg19QQK6KjXRi+ShwIZQYf1FGF
         fJfQp0pFU4N+oKCiSMLLlxse2TrSItSRxiPuxcAd3gza7L1KhGGjfDS/bX/wO18Uu2ve
         T8CFLd9ALTvMOqkXjbraKedriHdXEqN4tDMnPidTiJad0NDo0nTN9IxcCaAY+db9y4nd
         Ezvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=+JExG4XECleL3z2Pr60SpUDE5nO3vODyjR9bd8Nc6kY=;
        b=VqVh5Ql37YcTD51jNZd+2p2ahqxuvZprbbkD2nadH7tI0ETYPcq+UCxeROiBaTNmlu
         hdqrczgB5cpJrPoC1VU19lv01N5aJuBFXhjEPNcWKzBKDZsbTWeWWXWpYcxezJpUYEzv
         f7QJ6KEXZdIAzZbY/NWKudycTNfPvXjfySkss6G6JFanQqBz6j/ELugVIoN9hv8cRBSl
         MLgZ3/L0o70NPHvI/o2zF9/1Hs3tpEktzlukvui/nUnUIrWExF42m1rIiKCKuHi+WZgu
         BuE2HN838RBpeBTBRAnFqWrWNi29cjPYX+kfLnFwln/P82xsdPQBAK+A27xqRv0oeyN2
         5UCA==
X-Gm-Message-State: AOAM531IdLr2vfAxcJla5jNvrbZ3JLZ5HE1evK4lTqX9NI7Q+peDSXyw
        mGFiuchaVc5vWxPG8VZfNsI=
X-Google-Smtp-Source: ABdhPJzPhhOosNm252jEChaJYoVGZl7+p4WEyFhZkVYZzw6EFuipLweGnv21Uc5sEsOf9Z4wP/PvzA==
X-Received: by 2002:a63:5703:: with SMTP id l3mr639309pgb.338.1628548766134;
        Mon, 09 Aug 2021 15:39:26 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:df1c])
        by smtp.gmail.com with ESMTPSA id 15sm16758375pfl.186.2021.08.09.15.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 15:39:25 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 9 Aug 2021 12:39:20 -1000
From:   Tejun Heo <tj@kernel.org>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v3] blk-throtl: optimize IOPS throttle for large IO
 scenarios
Message-ID: <YRGumHUfK5sJc4A/@mtj.duckdns.org>
References: <65869aaad05475797d63b4c3fed4f529febe3c26.1627876014.git.brookxu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65869aaad05475797d63b4c3fed4f529febe3c26.1627876014.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 02, 2021 at 11:51:56AM +0800, brookxu wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> After patch 54efd50 (block: make generic_make_request handle
> arbitrarily sized bios), the IO through io-throttle may be larger,
> and these IOs may be further split into more small IOs. However,
> IOPS throttle does not seem to be aware of this change, which
> makes the calculation of IOPS of large IOs incomplete, resulting
> in disk-side IOPS that does not meet expectations. Maybe we should
> fix this problem.
> 
> We can reproduce it by set max_sectors_kb of disk to 128, set
> blkio.write_iops_throttle to 100, run a dd instance inside blkio
> and use iostat to watch IOPS:
> 
> dd if=/dev/zero of=/dev/sdb bs=1M count=1000 oflag=direct
> 
> As a result, without this change the average IOPS is 1995, with
> this change the IOPS is 98.
> 
> v3: Optimize the use of atomic variables.
> v2: Use atomic variables to solve synchronization problems.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
