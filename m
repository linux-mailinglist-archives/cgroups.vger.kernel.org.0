Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A08620D246
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2020 20:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgF2SsF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Jun 2020 14:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729352AbgF2Srp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Jun 2020 14:47:45 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1116AC030780
        for <cgroups@vger.kernel.org>; Mon, 29 Jun 2020 08:09:50 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o22so3092211pjw.2
        for <cgroups@vger.kernel.org>; Mon, 29 Jun 2020 08:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NqlmVG78iXs3ajjXsqe/luI6Bsp4Jqxp96Da7CCW4P0=;
        b=m0swvNT5I4fsJ5e0cVdRCGoS4Gep1sPkCbXehbvbkq+AANBChxcAllGhlBu0NrflKc
         i75XmYCkOQ7onW5AoCG6eCrz24Tr7rgsr7d0+eu0uJtAiS62ODVgPZ1+T+nd+gNZPk+K
         tz9fcA9G3gIiKOVi0fOebGPrsDXPjX1qqHNGuq3d/S36WOD2Awto4/RKwsVUrRXp5l60
         FbKtJnwhq8Nevr37M3deQWyv/IqzYPtC8a6O9fKz8k7GN7/N8WAuFzzUTmwtynKD2yuQ
         Uf/lFdAUyyLcs3eJhIzvwxHyTImxc1Ln5ZACcRGG3UEFWISgdBleMn4XbujIAFsjsCmP
         esIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NqlmVG78iXs3ajjXsqe/luI6Bsp4Jqxp96Da7CCW4P0=;
        b=qe/druLhhSmQEk0AwEZsApGVDOFCVceTtW88bKxWz55yDhcID527yxnHgQgAc1wwaO
         29w+GMALPmNd8v6e9Mw//Q55kVQhsJfmLxk8FIxfWBKjr8qJAd5r5E8abn5QkFPvH0mS
         LuJ6mn3Z+B56qLi1Xr236+jYD6G50UAnEcHSbglNPpkUzZkEzz/peiKIbocaFFc5/peX
         dn+4eUyNabWtYYgi9pM2nug7dtPZeAKj4XQVAIXMMRxfC9/+EwnK/H0ObyUZDR+0lYU1
         XpFh2iIGL2GurfRc++qHFiaCSbzTUsykrhjHNoJFR9XgBGLEaAtjLOe9IJaq65OV7CVu
         roQg==
X-Gm-Message-State: AOAM531jYE8jM2TLH1ZMsKBYI1/zN2KF5Y6UjpIxkuSX24q2nQw4yAPj
        LMXShC6ilacDd9y3sBrj8I5I7Q==
X-Google-Smtp-Source: ABdhPJxwZjsguM484F6sMiKLUZjrGQV40HFdBT3LN52GuV2BrrlgN4LhTVhem+onWXtopEtTIEUvTw==
X-Received: by 2002:a17:90a:222d:: with SMTP id c42mr11700791pje.126.1593443389436;
        Mon, 29 Jun 2020 08:09:49 -0700 (PDT)
Received: from [192.168.86.197] (cpe-75-85-219-51.dc.res.rr.com. [75.85.219.51])
        by smtp.gmail.com with ESMTPSA id p19sm83847pff.116.2020.06.29.08.09.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 08:09:48 -0700 (PDT)
Subject: Re: drive-by blk-cgroup cleanups
To:     Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>
Cc:     Dennis Zhou <dennis@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
References: <20200627073159.2447325-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <90c404ed-58b0-274e-516f-b7c63ce34fcc@kernel.dk>
Date:   Mon, 29 Jun 2020 09:09:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200627073159.2447325-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 6/27/20 1:31 AM, Christoph Hellwig wrote:
> Hi all,
> 
> while looking into another "project" I ended up wading through the
> blkcq code for research and found a bunch of lose ends.  So here is
> a bunch of drive-by cleanups for the code.

Applied, thanks.

-- 
Jens Axboe

