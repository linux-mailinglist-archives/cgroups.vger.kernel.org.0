Return-Path: <cgroups+bounces-11837-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B125C4FC97
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 22:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF42F189C0ED
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 21:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E32264612;
	Tue, 11 Nov 2025 21:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dDmdMGQ5"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EB1277C9A
	for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 21:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762894903; cv=none; b=BFg+KKpQgoCYF1FSuqv1X928xnemAHhO7Yo505pJKsZa2omrvqMSeAQ7z1W6iBSA01sV7oydx/n/Od6KiLIutR8p1bDm0YIXPUgiEBA97gs2rj7nCC0cEEmLzHarE6Us8k9jBX+mvSFBOqfJF36HtgmptTC+Y1gwfP2cVBDXZfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762894903; c=relaxed/simple;
	bh=00mv0TjCUbXDRMs+VKrHJYkUdKXkKT462q4ka73JY3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=th92BYn9zTLK6Q6wAMhSVFJ+8zCFg0hmvPj6kHWzG+TmpgeaP84MNsbMHsW2mDr4cbx19V3IpcWgi/NEX58MvDGOBU7AaaKoj9UVEFbMPRmjStfB9uIvNcvqiEYf8Kmj70Fnc29tjEI89+iTTpT8V+F1L5CDn8Ak9K0ssv9DVqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dDmdMGQ5; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6417313bddaso156384a12.3
        for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 13:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762894899; x=1763499699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AOtZbxVqz3T0EH1q1J5hisXUupKcXN5oOYovjWYI2BY=;
        b=dDmdMGQ54eC8AihcZoP1DwUwOZ84UMouBumbPJmV7NyCMUXstvKJNRbpr/2i/Y8lAP
         RWc3Y6kUcJd7s41Il2BObfyPZBL7H9XOFTI5xHZhIM1am1rQ3ybdkwUpizbWuW+r4irl
         P06SHJbecjOuAqv2kzWfeK/dtBosGE5qa8DabdYshiD0Yjz6md3dVbL4LP/LTFK8VJ1S
         FhyaoQfZ813cmSsgU+jG5V6hhr33/xOdbcCujRuhfhtOdqRa8W6F+H52EygoTObM09gb
         Su0ABP06YmSP/zcJPGny4F00RnNy+vnvDR8J+mnciacD0gv5KjkbjJiF5R42GQ3pCF25
         pD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762894899; x=1763499699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AOtZbxVqz3T0EH1q1J5hisXUupKcXN5oOYovjWYI2BY=;
        b=QkN6Jt4pGCVfQAVS7M629V9O4ReQ93GKUrPXdbuZt+o8dvmNmNjPdTtY0jIhr7dDVm
         hsTBsyQr4CIBriTxTbLBW5vxVYMR4oLhqXLFNUyMh4In0BGyNNONMIEAgnRpHCv+tCKu
         MevlaGDScb1tZ/VOLfiAaOUsP0DchEGlIaHOt9xWR4zvhzuElg29cxuNegviIL/UO2Wh
         7DYP3S/L/GVo8vkRbALAKXaXK/0bAiS9LnsNCxM1711X7VB+OVSptrCX1VuLgsHGpMdC
         VgnqYUWWFBnVu2VUOXCogmh3U0LUPsGOCg4I3dM7o+GYe05SOZYrnMEudUrrQFN2CX8F
         plhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMB8h8hJJ1rwbgA70RRFqwlW/7cFGn3REjCqNyWhOtM5dHXst8/HjIOL8Zr4HTNDLgU7sS/ZAl@vger.kernel.org
X-Gm-Message-State: AOJu0YwENlxQYTs2remvu+JVcPC8UVhto0Gs9Bf3q4E65gN0xYOXwrm0
	HmEf7GiXM/2u1kKO/861Nf/RkXWIreGGwPqJARtckGjVEDAY5e1TYTlVH20BglAkz1M=
X-Gm-Gg: ASbGncsMO4HzR1oEiiS2ein0hq4Fko8VTTOBcprXawsB9Hqlwl5hHPyGUBXnWhcaIJP
	c+DGFCCOnmmVYtKtyWlr3YxbxKdsqN+MrfGgTujktN9+7eY7sAUw32yBHCEB7tvvmfaWmUhF8L8
	LzDAU6bHXBa8Jp7i8eQnCO3HgMuVxjP9xKvGH3bZAuNVN0DtgO5545nHs3DCMdIOBm0IzSwWPpY
	92CaCK3fRHDOQUEIYubXwHSzUjyBJcDhcmLiic6sjux8UjHuuqCKaVyKuI+/bE6gksEDbhmsYyx
	xDzWECpz4ggNqmfd74GwzpsutAwo1jbjwotIDZhpUiwrzXZRqDNatEaCKH1sRPqhugW60tnYDvQ
	1PwskWxoeVrdKgJuA0ca3+MW9JVi3/OD2ehK/57qopoP3iy4PPI9QCNyhVFtrxBnnzzes3BVukn
	ZH6oOqZrwOnfLiwJHaNksq3+cE
X-Google-Smtp-Source: AGHT+IFHxQR5RsZZYuu15UkFc5wCGawdUUh/83F65t7RT/bR8gwY77ILDOKtOxH1D+cIwgNbNyoHRA==
X-Received: by 2002:a05:6402:42cf:b0:640:9d8f:3c73 with SMTP id 4fb4d7f45d1cf-6431a577ae9mr518057a12.32.1762894899315;
        Tue, 11 Nov 2025 13:01:39 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f86e12fsm14093400a12.34.2025.11.11.13.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 13:01:38 -0800 (PST)
Date: Tue, 11 Nov 2025 22:01:37 +0100
From: Michal Hocko <mhocko@suse.com>
To: Waiman Long <llong@redhat.com>
Cc: Leon Huang Fu <leon.huangfu@shopee.com>, linux-mm@kvack.org,
	tj@kernel.org, mkoutny@suse.com, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	joel.granados@kernel.org, jack@suse.cz, laoar.shao@gmail.com,
	mclapinski@google.com, kyle.meyer@hpe.com, corbet@lwn.net,
	lance.yang@linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH mm-new v3] mm/memcontrol: Add memory.stat_refresh for
 on-demand stats flushing
Message-ID: <aROkMU-OFAmYPBgo@tiehlicka>
References: <20251110101948.19277-1-leon.huangfu@shopee.com>
 <9a9a2ede-af6e-413a-97a0-800993072b22@redhat.com>
 <aROS7yxDU6qFAWzp@tiehlicka>
 <061cdd9e-a70b-4d45-909a-6d50f4da8ef3@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <061cdd9e-a70b-4d45-909a-6d50f4da8ef3@redhat.com>

On Tue 11-11-25 15:44:07, Waiman Long wrote:
> 
> On 11/11/25 2:47 PM, Michal Hocko wrote:
> > On Tue 11-11-25 14:10:28, Waiman Long wrote:
> > [...]
> > > > +static void memcg_flush_stats(struct mem_cgroup *memcg, bool force)
> > > > +{
> > > > +	if (mem_cgroup_disabled())
> > > > +		return;
> > > > +
> > > > +	memcg = memcg ?: root_mem_cgroup;
> > > > +	__mem_cgroup_flush_stats(memcg, force);
> > > > +}
> > > Shouldn't we impose a limit in term of how frequently this
> > > memcg_flush_stats() function can be called like at most a few times per
> > This effectivelly invalidates the primary purpose of the interface to
> > provide a method to get as-fresh-as-possible value AFAICS.
> > 
> > > second to prevent abuse from user space as stat flushing is expensive? We
> > > should prevent some kind of user space DoS attack by using this new API if
> > > we decide to implement it.
> > What exactly would be an attack vector?
> 
> just repeatedly write a string to the new cgroup file. It will then call
> css_rstat_flush() repeatedly. It is not a real DoS attack, but it can still
> consume a lot of cpu time and slow down other tasks.

How does that differ from writing a limit that would cause a constant
memory reclaim from a worklad that you craft and cause a constant CPU
activity and even worse lock contention?

I guess the answer is that you do not let untrusted entities to create
cgroup hierarchies and allow to modify or generally have a write access
to control files. Or am I missing something?
-- 
Michal Hocko
SUSE Labs

