Return-Path: <cgroups+bounces-6120-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A559EA10306
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 10:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCDB51675AC
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 09:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B8128EC68;
	Tue, 14 Jan 2025 09:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e9J2YGWq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC1F2500D2
	for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 09:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736847011; cv=none; b=bQb6dZ3+ky9qq7NhqKJXC5yo2ELbH9p2YbEGS/CT6NoLpSvZOdLn4eurqPIluHGaO4mb9GlNj3wnoSgrjYCG7Ig7z4Tzce0wCIUQQ4AfbTmVIPb4aWivDNTGMYslMkeS8YZBEYGsk6XfzhI8RyCqP2Zw7YabsNDzbJfWEgK+kik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736847011; c=relaxed/simple;
	bh=Z7+RW9Ce1zoISb8HQk/q0TTOg8DkZTp+QNNQZLVUi7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k70vM1x/Hg+8XVrh1mKz46rfpSjJuYqV8Zod5G7kAusfCBpun11ouMQkaaI4V348wIGk7vwHr34q/8Vmdk7qu3tk/U0mqmlYwgIcKEG5QiV4PR9XF/kKyVoZhcFhdK6qoGJcpPpbAACmRm7c2ZsXNwW1pXvf89yVIB4odRzrJGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e9J2YGWq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4368a293339so59692785e9.3
        for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 01:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736847007; x=1737451807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4YGmWmycezS9jkVnxAS2Bxtl3GOSpauTsYhEt8L8EWw=;
        b=e9J2YGWqUEut9Obhk2Os+CMuw8ls7aNSwA865cu5q86qROkVwqpSj6EhIzs1YyhSNH
         O0kbTmT+0aWsmPPVA0zpDmtHQKrKJyG7004maBw5qwJnpVSQac9NTfWB6RunERESluoF
         QpEu+K12rZnBYo42qMF2wodgEb0Nfq3Dn9TqQSCgadROtjgw7e8TPmGYC/bZxe7n/cNO
         De3wbsMTdM4n1VRM9iSs2Kml2vpsidTVhDcKdT8JTENWPvwmT437jWASTMzjisreV3/8
         ZYzcEqet1lSVsf+PaPxXMGSxmBGt1sCL5d4Nj+c5s1paAW0Uo3tu4QW+cBlYj+fm3MiF
         Xkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736847007; x=1737451807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YGmWmycezS9jkVnxAS2Bxtl3GOSpauTsYhEt8L8EWw=;
        b=qqSWPl952Y/ln4CsF0ljhTXN/jVQuK/+CEzMbmJmoMYtLIgmgkQaC2TKJqebWqQUqU
         gFCvuxNk1544bYXA5xksK0UB3Q/THCg9NxwZeZ8PeSD6fTIUQCGzSASpcp3vyKox6f+h
         llJsHNbglhfCEhwnLH7MAdU70GKLXDmC04/ngUpGWOLShUei7HdDLPMTu2mbwuoMin3S
         o+68XGCxy31wxOoPJPjD+y+Y86XUcpn5LbkIhYhstGinXw+mIHWToiFIMrtYDUUvqnal
         mSaV8050lGyAVszQxXGltAIXIKZY25Rwz31QRlSXa87WWJmmdSE1byZzOlzuw7Tv3FBw
         6wEg==
X-Forwarded-Encrypted: i=1; AJvYcCWDlkv3eiaHgijwDm8KsikkeYSBty4KesUuWMT7CoVEHlMZxWOW6c0nDsls6dUePNgDaES8GBdK@vger.kernel.org
X-Gm-Message-State: AOJu0YzRqMgqBwKjECesoXjNWyBQxB/sWQt8TrSTmRhyxLJRx12zoxCV
	sxIy/YF/Rg8voCE5XaqYhhWxl12lucbSekElONEKy80h1mGDUCYvMRxYVsDfN9c=
X-Gm-Gg: ASbGncvGqWWht9i8NM87Gfc1egYfj8mOPR+fFEtmBmpcXJd4X6A+NH4q6F+krebvfe3
	+iWP7s9EtueBJaNieDDbzoa3BrCJWG3QdA6ZR6jOAEF87GVv6LO9ZIxoj23bgDf8q9gWeOC73EQ
	E77FjJUebm17ddeIUzhwnkIms7wmKlFFIr0odGFhTzIpADlM7fgCmPki781ic62cY3Gr40BfRFw
	it7HBhDwywda2AY7Z8KQvEcIgBIip39vPHM3Zlv/e4us9qSDRNkgBcvFZBNcbZVluqadQ==
X-Google-Smtp-Source: AGHT+IGhGtegehO3VtVkIsPaihdSAsIF3SnjAzZnyb48GAvKI0PiF5sJYWYJLFah/z6gYy6ZH3XHeQ==
X-Received: by 2002:adf:b197:0:b0:38a:88b8:99af with SMTP id ffacd0b85a97d-38a88b89a0amr16749637f8f.22.1736847006667;
        Tue, 14 Jan 2025 01:30:06 -0800 (PST)
Received: from localhost (109-81-90-202.rct.o2.cz. [109.81.90.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2dc0069sm205545485e9.11.2025.01.14.01.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 01:30:06 -0800 (PST)
Date: Tue, 14 Jan 2025 10:30:05 +0100
From: Michal Hocko <mhocko@suse.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chen Ridong <chenridong@huaweicloud.com>, hannes@cmpxchg.org,
	yosryahmed@google.com, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, davidf@vimeo.com,
	handai.szj@taobao.com, rientjes@google.com,
	kamezawa.hiroyu@jp.fujitsu.com, RCU <rcu@vger.kernel.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: Re: [PATCH v3] memcg: fix soft lockup in the OOM process
Message-ID: <Z4YunYyj6oqmdrUt@tiehlicka>
References: <20241224025238.3768787-1-chenridong@huaweicloud.com>
 <1ea309c1-d0f8-4209-b0b0-e69ad4e986ae@suse.cz>
 <58caaa4f-cf78-4d0f-af31-8a9277b6ebf5@huaweicloud.com>
 <20250113194546.3de1af46fa7a668111909b63@linux-foundation.org>
 <Z4YjArAULdlOjhUf@tiehlicka>
 <aaa26dbb-e3b5-42a3-aac0-1cb594a272b6@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaa26dbb-e3b5-42a3-aac0-1cb594a272b6@suse.cz>

On Tue 14-01-25 10:20:28, Vlastimil Babka wrote:
> On 1/14/25 09:40, Michal Hocko wrote:
> > On Mon 13-01-25 19:45:46, Andrew Morton wrote:
[...]
> >> > For global OOM, system is likely to struggle, do we have to do some
> >> > works to suppress RCU detete?
> >> 
> >> rcu_cpu_stall_reset()?
> > 
> > Do we really care about those? The code to iterate over all processes
> > under RCU is there (basically) since ever and yet we do not seem to have
> > many reports of stalls? Chen's situation is specific to memcg OOM and
> > touching the global case was mostly for consistency reasons.
> 
> Then I'd rather not touch the global case then if it's theoretical?

No strong opinion on this on my side. The only actual reason
touch_softlockup_watchdog is there is becuase it originally had
incorrectly cond_resched there. If half silencing (soft lock up
detector only) disturbs people then let's just drop that hunk.
-- 
Michal Hocko
SUSE Labs

