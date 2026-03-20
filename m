Return-Path: <cgroups+bounces-14936-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDEDNkUUvWnG6QIAu9opvQ
	(envelope-from <cgroups+bounces-14936-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 10:32:53 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BAC2D812A
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 10:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94947303FFDA
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 09:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EE7372B25;
	Fri, 20 Mar 2026 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SY7DaewO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7233750CB
	for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773999169; cv=none; b=BGDDBnQPwLUkBDorbRcFLJgsD8aXm61XFYxaM3hgtgogms75a2eo9eie3j//RKSZFI9yqkJnVdNBxdtiEqh1RoR0jvqiRT4JeZIVmVFmFjsEOW4LDeV45YGfhgIaNGgbvcnpTwuS9mxJ1Mwk7hIKYqYkcZKzp0K1VZaGeTZSqvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773999169; c=relaxed/simple;
	bh=FpNtDIA6oOfc1i8Qt5ngbRNeLYofROBoR5hcrINPuNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGZbwjCDY3zba2C8qmqUav4Kdbm1htwHlCbCO/sPf/wUOMDGZrg1GeoSA9qrDTZ1EW1nkq1vTD08T7IeK5PRK0M4bE31sV14WzHJIx5Wuh84XhjnP5MWkypLmCcBQKPFsljyAV69vZr3RTDu+IU7O/HRkJY6Pj/IpLdGP0YhEJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SY7DaewO; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439c9bdc1eeso1558652f8f.3
        for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 02:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773999162; x=1774603962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OM7qYlf9HKURWz/+a3T3Y3rxMadnxIAJ8Nie9c0bxzE=;
        b=SY7DaewOwGJuz8oSJ1n/+tO2+3bE07s0CMA6qOM7klRS4ejIt9S6Vf+PIgjOESBYZZ
         hz2kOuyTJdco/0JKsSGcIoVlTBNEDb8d/Mpg8uDaHGZihW8D4Aro+51FqXAqNp3mjMvi
         o7D1GSpuIHUc5pHDzF9IJ2N/IMV0sXeySnmo+3/eTa6hZqoWAv3kQ4V2PWNxjyzx2g1u
         DJ+0nmJrsqDoJpJWlyqPEKpVXsJ3gpXiqkBBudfBoazQHR0G9/NSoRf11F/rJC5xtQ5w
         gzmI3MSLbcvgfflou3dk0dUbhZM8mKiWbFC126Qq8MkgJD3Lkh9nJ3IoET6h4M+061Y2
         wUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773999162; x=1774603962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OM7qYlf9HKURWz/+a3T3Y3rxMadnxIAJ8Nie9c0bxzE=;
        b=Q7zYeYN/RXUKONALSD8xyPdz2N1MA09a0HrxaWkQb0Jc0bnAw6DRV7evZBce0LelW1
         49cRE5+m9cZp0VESgonTpbc7sFGQohQgMZkC1TYPgGXN1uFldE122QdaW3hJ2Ok43wfD
         qHyEdnn/rEMj/j1U/qBlNFjPqghUcpuyy9ZGIXvnpF5rtI18Ls+9sfNxID9DlSVvK1lF
         utgsXPkom3g3SJWtcWQGUL7HhniJ3kjG+mJHpLTC3bbRHbvDfBIAjdOGQUDu2SRPvT+B
         R8exCZo/EnG4p6jAXiN3s/0ERObTFYKzT0GPfM1zwZuPYBGIYwuiwQwX1icMzDT3J0zy
         mIJw==
X-Forwarded-Encrypted: i=1; AJvYcCWSAVTc4SrEOsYTfXL/RM/tcqtGggLrnRFo5suI8FHb+cUa4E6y86SyoICzSaTTEhRTajEltOUE@vger.kernel.org
X-Gm-Message-State: AOJu0YwP02OIiSwZEPXmlz2CD0r7g2k4a3g14FxmiQx+nivzXiqmGt6d
	uUju/WIH+bjBRS1Gn8q0hqCRVwsa30ihbtjFGvA5kecUlv45RR5Ku5NXIJgQpzSRZiVYoJysi0J
	lBV7r
X-Gm-Gg: ATEYQzw7Z0A3CcG9xHjwjbH4PFXlxPCjLO1eZYqagE3PB5FpBFdPgRp2pqwORg3ucnE
	JwOdA8IO+Sv7scOFawrXcMBjQ5PYEGS4QctuD0dzwdB3bYPwP3tU6R4e3BI9ESJwv/4IywWiTzO
	XhFsR63KVDDZr0LX738ZxFCtvRCTX67fTvQJf1ObuAABHizYduohQAnQZPCv0fphrLwwPoDWGeB
	adBWJarckzsTm9Q1f3Gw2vsBkI+SKMoqL0qGdMVQtcUW8JShRutxil5Ct5euEobIO3znxg679RQ
	TYht8IyPEgvDATCFMllVpDuyat6FkMiApn0VCtEY+0Cv4lpOjFzEQW9ZasmyuiUi1JBe/i55FwC
	9iRi0exOWb48uuMaSjfAUX8XIBuTHj+lSA26FszRf+K6V6qJqnDMSOxKbVGksrVb3Pg2Ua9QWZA
	oH0qXdV3L4lEpNz7vVkvLD6CNcpdSHQ0KQFQ==
X-Received: by 2002:a05:6000:608:b0:439:fdd5:10b5 with SMTP id ffacd0b85a97d-43b6426d710mr4221954f8f.39.1773999162404;
        Fri, 20 Mar 2026 02:32:42 -0700 (PDT)
Received: from localhost (109-81-88-11.rct.o2.cz. [109.81.88.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703c27sm5170510f8f.18.2026.03.20.02.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 02:32:41 -0700 (PDT)
Date: Fri, 20 Mar 2026 10:32:40 +0100
From: Michal Hocko <mhocko@suse.com>
To: Bing Jiao <bingjiao@google.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, baohua@kernel.org,
	bhe@redhat.com, cgroups@vger.kernel.org, chrisl@kernel.org,
	david@kernel.org, hannes@cmpxchg.org, joshua.hahnjy@gmail.com,
	kasong@tencent.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, ljs@kernel.org, muchun.song@linux.dev,
	nphamcs@gmail.com, rientjes@google.com, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, shikemeng@huaweicloud.com,
	weixugc@google.com, yosry@kernel.org, youngjun.park@lge.com,
	yuanchu@google.com, zhengqi.arch@bytedance.com
Subject: Re: [PATCH v3] mm/memcontrol: fix reclaim_options leak in
 try_charge_memcg()
Message-ID: <ab0UOCqHmZG3hcJ2@tiehlicka>
References: <20260318215629.2849052-1-bingjiao@google.com>
 <20260318221957.2979346-1-bingjiao@google.com>
 <abvB65BYCUDT9JF1@tiehlicka>
 <abzBfHzRndwjrGQY@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abzBfHzRndwjrGQY@google.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14936-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,google.com,kernel.org,redhat.com,vger.kernel.org,cmpxchg.org,gmail.com,tencent.com,kvack.org,linux.dev,huaweicloud.com,lge.com,bytedance.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-0.972];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim]
X-Rspamd-Queue-Id: 68BAC2D812A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri 20-03-26 03:39:40, Bing Jiao wrote:
> On Thu, Mar 19, 2026 at 10:29:15AM +0100, Michal Hocko wrote:
> > On Wed 18-03-26 22:19:46, Bing Jiao wrote:
> > > In try_charge_memcg(), the 'reclaim_options' variable is initialized
> > > once at the start of the function. However, the function contains a
> > > retry loop. If reclaim_options were modified during an iteration
> > > (e.g., by encountering a memsw limit), the modified state would
> > > persist into subsequent retries.
> > >
> > > This leads to incorrect reclaim behavior. Specifically,
> > > MEMCG_RECLAIM_MAY_SWAP is cleared when the combined memcg->memsw limit
> > > is reached. After reclaimation attemps, a subsequent retry may
> > > successfully charge memcg->memsw but fail on the memcg->memory charge.
> > > In this case, swapping should be permitted, but the carried-over state
> > > prevents it.
> >
> > Have you noticed this happening in practice or is this based on the code
> > reading?
> 
> Hi, Michal, thanks for the ack.
> 
> This issue was identified during code reading, when I was analyzing
> the memsw limit behavior in try_charge_memcg(); specifically how
> retries are handled when demotion is disabled (the demotion patch
> itself was dropped).

OK, that is always good to clarify in the changelog.
-- 
Michal Hocko
SUSE Labs

