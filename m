Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63634409BD4
	for <lists+cgroups@lfdr.de>; Mon, 13 Sep 2021 20:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346507AbhIMSK0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Sep 2021 14:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346508AbhIMSKY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Sep 2021 14:10:24 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC425C061574;
        Mon, 13 Sep 2021 11:09:08 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id h3so10209798pgb.7;
        Mon, 13 Sep 2021 11:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i1ekjg9yMuKBiH8XeW5HvCgZVasiBrWrygr7iOMv0/w=;
        b=FLD44LaaQn9HDkF4eTXX3iAjKbIr201+F8gAoc3gLLSVcedbAzA++CFkMiEzIhUrjk
         KEMPeoKz0lCQLFx9206No+8jSKhcwXXgFG+ycog5v6v501NW9ZiPlKGg1KvUCSljbESo
         ZJxXIR9hRr9nD7VLNTvnydnFM/CGpeayTchioTqW7W45vsZefKqSQYFr48F1Tdvia16g
         27S1J8VTxZLIPv9bBSL6J7we4V1toTVBwlQCRVkjuGrqOvnPr9uB1HKWimaMtEgD7l4r
         rdQAbkzz/xtOcZw0S5Kb16cNY5qSwwVGLb+fPSDtPa0R8nIksJxQee/lPMY1NHbYq7fy
         PvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=i1ekjg9yMuKBiH8XeW5HvCgZVasiBrWrygr7iOMv0/w=;
        b=00F7mZM2aIeQsllHw2kvDzhMEX4BdMeCQZ0315EhZ7ktaZ4mu365n1pToiffu/kA7e
         JXGU9MW6KvtYudEa4X1PdJ1Y8XPNbCj2sycW2Ymgg9XAMLpgGe+Vwj+RPEpdMI3BTsi7
         4BQfGhry1BnnMSeqWGaovePKWI8q1tJpoMHirdHJcYv+nWMf97KkfZ3L4s5ftDUHN9Ly
         WMLfBbnej+nWjy9ZxkBCGWLW5WuoxkdWINsbI24/efSyvtOnSpe2CjWD4P3rpPG30Swl
         CmWor1n+WpXTjO5qOy5NoKQ9YgAD3AeOgRQbEI5Yj4jCjTbho5vi3jZF36iT7dh37m2G
         ZeYg==
X-Gm-Message-State: AOAM531C6/zkEhMz/yemr/uBlLrLIbxMM9rUryzRmEOAFrO4f1fZuLqf
        nwMTIzpQ1yjrriv+Yw/3IzQ=
X-Google-Smtp-Source: ABdhPJyTWm2jzYWMRxBJCzI/nB/AWKEXxojzSUo+Sx2oIaKgTrrsQxq4n55U54BSRQA3pifbRIIDfQ==
X-Received: by 2002:a63:4917:: with SMTP id w23mr11987407pga.344.1631556547481;
        Mon, 13 Sep 2021 11:09:07 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id p24sm9418286pgm.54.2021.09.13.11.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 11:09:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 13 Sep 2021 08:09:05 -1000
From:   Tejun Heo <tj@kernel.org>
To:     ArthurChiao <sjtuyananzhao@gmail.com>
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        ArthurChiao <arthurchiao@hotmail.com>
Subject: Re: [PATCH RESEND] cgroupv2, docs: fix misinformation in "device
 controller" section
Message-ID: <YT+TwTmPEliba601@slm.duckdns.org>
References: <20210908080815.130952-1-arthurchiao@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908080815.130952-1-arthurchiao@hotmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 08, 2021 at 04:08:15PM +0800, ArthurChiao wrote:
> Hotmail was rejected by the mailing list, switched to gmail to resend.
> 
> 1. Clarify cgroup BPF program type and attach type;
> 2. Fix file path broken.
> 
> Signed-off-by: ArthurChiao <arthurchiao@hotmail.com>

Applied to cgroup/for-5.15-fixes.

Thanks.

-- 
tejun
