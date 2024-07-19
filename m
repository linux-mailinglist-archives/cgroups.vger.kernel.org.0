Return-Path: <cgroups+bounces-3821-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC9B937B9A
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 19:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A17671F219B2
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 17:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AB6146A73;
	Fri, 19 Jul 2024 17:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQHGVkWw"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17250146A72;
	Fri, 19 Jul 2024 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721410317; cv=none; b=J8OA4QF4eLv5IuzECrfdOzWGwkjK3ClE0z9Pm8Ky1gS4LwWgHcju8IzcFY7V5Oj7ntBgnMG52STycJEMRX6HeqCrSTsUff2Vm7/i2r7gPBTfFbW3vnAMSyACaZJJkEhpajIufZTIlecKXx3bGRIr/0e4mqu/Kp1bkBZPeDWrDyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721410317; c=relaxed/simple;
	bh=kwetyPKGOW4u/OrTUJz8Yw6DPPnSPhY2KQ5TC6vHHeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQnw1ae6m1Qb6pwGddeMy3paTvQxF8GKCOAEe/mMYjM5iQV5GrI03Tji/WCsGJ5YNRSqm6gYHvMWv6gnN7k6na7Ojm7H67iih6aYp5EVZDVUVsXb0c4kizNPKPGsf0n+FWycaFqPolc22uK71IL72vCoEw7nroSMC+10QuzGmXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQHGVkWw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc65329979so15664585ad.0;
        Fri, 19 Jul 2024 10:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721410315; x=1722015115; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ZbMHz0p5DWuVseBb2N8rhX28Nxn5bBUC6D+VNe4hHM=;
        b=gQHGVkWwSp8T6LffMGm2bRwfKY/sSdMkSP1Vi37rK6A1voQnOfLQ7mZEXAxXmkuGNI
         9nkFaE6hsez2Oa+taaKGUBB6jtSCVXWvwUdoE7tioR0poQN7NJPEkkOJ4QKiLfcOmoZk
         zyYHyrdr1dmmGPBafg1+RClwxnMKj7bNFObxdaGrnZiEK7zH4SChyI0yPtMWYAZ6SLXn
         aO7206XkSapP4sxIDBrQXsbPGhHe47TVMcEBAIvHnpPvuZK9M034lR7DTfMe3zFNjwst
         c8/UR52Hvto1sXJPpt0xVtRdhxQlqzQmlhn/wgiGUp/dB7M3Y53rq4wbR5R3UngLMIbx
         9KJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721410315; x=1722015115;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZbMHz0p5DWuVseBb2N8rhX28Nxn5bBUC6D+VNe4hHM=;
        b=bartIFUSmJGSxk5AUlA5Z572/eQpfWr5aeu+kKtKmlFOm/dF9kMRVAxA6N6++rit6v
         m3wvW6Le9JK4etlvie+bhJO9SuVVYCLsM0xOUYxqLqtCZJasKziEelwzPO/iSPJZY2ze
         B1rHtm2QGjdKm/foEO92fEcfbDnftgrviPxR7TWi29biKa7KcUfZ4eM95IDfG+wgYob2
         4Jz9jJRRkEzf/OI9EupI7/KJqNI6dhQslBGmWf8sQ3TEnnHzMAWXmNUQZyCe0QI+Ki8O
         DEumr1AfL99nAxFfyLvbXE66Ewc/Sr+s1O6khzO6QydMCNDPPR7CL3bLkQwiZuqq5D0n
         nT1g==
X-Forwarded-Encrypted: i=1; AJvYcCW4pap9c4JCK3nX8l1rHJunix4w9hDK8Xa1E1mjqOhXyW5YE00I81Z6pFl+W+GMLcLuu4lFGZRTzF/CRfRKKwcKrd6y3+Yoj8q/owlURXjY16QwNB1UwdyyDH1wWb9v/22FIT7sZR1M9xxyZvfAoFbXGGPM5tfKb4yJga5bCM8HAoxj
X-Gm-Message-State: AOJu0YwHmMens86LZ9hERJtxwn+4IAdQBjWKAKINgfUao8aLB/uFgxiO
	XOLpvtvzBz05HGv/rNimpRgrOeBEVYVYuuSSOYJybTGUSRHb9XHhrQqTRA==
X-Google-Smtp-Source: AGHT+IFsThoFkOXcqDTCyPseR9byS+0442uGUbWIB1NvdVDLi0q/DrexI8yvkm4IqTHzGS1Ss2DQJQ==
X-Received: by 2002:a17:902:ec91:b0:1f9:d0da:5b2f with SMTP id d9443c01a7336-1fd745879femr4471445ad.39.1721410315354;
        Fri, 19 Jul 2024 10:31:55 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f48875esm7196225ad.287.2024.07.19.10.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 10:31:54 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 19 Jul 2024 07:31:53 -1000
From: "tj@kernel.org" <tj@kernel.org>
To: Boy Wu =?utf-8?B?KOWQs+WLg+iqvCk=?= <Boy.Wu@mediatek.com>
Cc: "boris@bur.io" <boris@bur.io>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	Iverlin Wang =?utf-8?B?KOeOi+iLs+mclik=?= <Iverlin.Wang@mediatek.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v4] blk-cgroup: Replace u64 sync with spinlock for iostat
Message-ID: <ZpqjCVxSAV-Q7Yhy@slm.duckdns.org>
References: <20240718084112.12202-1-boy.wu@mediatek.com>
 <ZpmF8HJsuefjC7Xr@slm.duckdns.org>
 <00c595a16b4e96ae56973ac2ce586f6ad736059f.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00c595a16b4e96ae56973ac2ce586f6ad736059f.camel@mediatek.com>

Hello, Boy.

On Fri, Jul 19, 2024 at 01:47:35AM +0000, Boy Wu (吳勃誼) wrote:
...
> If it is for readability, I think keeping using u64 sync instead of
> replacing it with spinlock is better, because what u64 sync protects is
> 64-bit data for 32-bit systems, while spinlock can be used for many
> other reasons. The root cause of this issue is just the incorrect use

Yeah, but it can't be used when there are multiple updaters.

> of u64 sync. Adding back the missing spinlock for the correct usage of
> u64 sync is simpler. Is there any benefit to replacing u64 sync with
> spinlock?

It doesn't make sense to protect u64_sync with a spinlock. Both are only
needed on 32bit. What's the point of having both? Also, note that iostat_cpu
is also updated from two paths - bio issue and stat reset. If you want to
keep that u64_sync, the only way to avoid possible deadlocks is adding
spinlock in the bio issue path too, which will be pretty expensive.

> > Also, for blkg_clear_stat(), we're running a slight chance of
> > clearing of
> > iostat_cpu racing against state updates from the hot path. Given the
> > circumstances - stat reset is an cgroup1-only feature which isn't
> > used
> > widely and a problematic interface to begin with, I believe this is a
> > valid
> > choice but it needs to be noted.
> 
> I don't get this part, but if this is another issue, maybe another
> patch would be better?

It's the same issue. Reset is another writer and whenever you have more than
one writers w/ u64_sync, there's a chance of deadlocks. So, iostat_cpu also
has two writers - bio issue and stat reset. If you want to keep using
u64_sync in both places, the only way to do it is adding spinlock protection
to both paths, which is an expensive thing to do for the bio issue path. So,
here, we'd rather just give up and let stat resetting be racy on 32bit.

Thanks.

-- 
tejun

