Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62A6C1008D3
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2019 17:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfKRQAo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Nov 2019 11:00:44 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:36422 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfKRQAo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Nov 2019 11:00:44 -0500
Received: by mail-qv1-f68.google.com with SMTP id cv8so6591961qvb.3;
        Mon, 18 Nov 2019 08:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dGjbHgjF0W1b+dELdkoZ7B3L1JrYsAni92y6q3z5/FE=;
        b=di4C7Z2zvQUq2pHY6TUUzLqSiEt9/bLv1Ph0DwW5GqtMpLNFg1Pktx/z/GnrNHEthd
         Ui8CGj0PhcU8u4+374VwlDbMAlVEvnUbsD5hNRM2/hQsUVWR0BeAf4XYFxKKedLzwW3B
         Xi4bVNSTvow7scHY0aC9DxHafzneE2vwVmMn9HGHgOVY2UoxLWJkbsbMLDVLTUPWn+iN
         d1AT+u/KGWCC9hI/cDDqjKgCQFctMZ1JSgs64xm3v5ZWuMFRYl6Be70fdZ+TQ6WCIRQI
         eU794I2pWW8u7KVfnFIznShljSZTY1ypXMJgeWz2gxRWbreI69oZOTOEGqtpLJUdxuap
         7FyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dGjbHgjF0W1b+dELdkoZ7B3L1JrYsAni92y6q3z5/FE=;
        b=FyZDMt8uvN6HyesaBdGttTxEz1/P5QiNI3bP+0bypH0agoQGSFxZjC2P/Dg3SUwNFd
         MJrMpp5DT0HGF20VAUJUcUch5XQApvyYRwvd87tViNNLd20o5tow/k1GYG8s7HsR0Fi+
         yf6cDWnPtO9X3CC1X+KL0doOTvokkPSMq23RLnxec1NM3uhLmfuQuUvYWs2Xq0zllJ0w
         SB8Engt6OFmf+bWG0x+tDuaO83JGnTYw6/BL8LPttQBFvSTOo14HeR+Ffy3/MnGA9xZz
         TYINod658f0g9vt9zRqNxalW+Cy8tUmGN/R2gQrfYzRP/ruQWY/0RHL2WuJkyFTtxomQ
         AqEg==
X-Gm-Message-State: APjAAAVImFXMm304x80dgKRUUzScD4y81SdupKk5mQFIvtniZCWYjiW5
        bIm9jL9ixSLHh3uyTnVfC3Y=
X-Google-Smtp-Source: APXvYqzAvIz0mWDXvlrm4wiWFX1y56FXmHKVJfOVX86U6TWJDAM7fzgvyiQr9bPvB0WZo9KVXYk2lw==
X-Received: by 2002:a0c:cd8b:: with SMTP id v11mr26925478qvm.66.1574092843284;
        Mon, 18 Nov 2019 08:00:43 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:ed5d])
        by smtp.gmail.com with ESMTPSA id r29sm10969991qtb.63.2019.11.18.08.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 08:00:42 -0800 (PST)
Date:   Mon, 18 Nov 2019 08:00:41 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH] docs: cgroup: mm: Fix spelling of "list"
Message-ID: <20191118160041.GU4163745@devbig004.ftw2.facebook.com>
References: <20191111144438.GA11327@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111144438.GA11327@chrisdown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Nov 11, 2019 at 02:44:38PM +0000, Chris Down wrote:
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: kernel-team@fb.com

Applied to cgroup/for-5.5.

Thanks.

-- 
tejun
