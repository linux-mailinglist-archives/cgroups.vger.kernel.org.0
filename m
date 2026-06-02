Return-Path: <cgroups+bounces-16556-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNzIOeiYHmoAlQkAu9opvQ
	(envelope-from <cgroups+bounces-16556-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 10:48:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4841C62ADDB
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 10:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0B0C304EBB0
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 08:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC783BAD96;
	Tue,  2 Jun 2026 08:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="c02LPeY/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31643C7690
	for <cgroups@vger.kernel.org>; Tue,  2 Jun 2026 08:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780389887; cv=none; b=cFYWiJekyPN6diJBQyc0ZK7qq0rjHx6Qk1rzqXqA6KHEJkUA58yMwpkykrzebD86opFtclOymQudyGz/Emx4MXamiUoTn6nZjz9L56qYVfA3isETG8xVO257AzDUK4HikCNYJ+Aui4bDV4t4EvgkdTFhOhWMYec514upk9SHqkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780389887; c=relaxed/simple;
	bh=1ehVhlzmJROiX2e+n+LZNczRiFgH3ZPLWk3mO/SSVgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Re4lbgLnvSjylSRGuh0Lu+Wi54+94CPqgYOidsUZsmluLHa9bGcAjCgrCi961ZprrmfqeHv9aHqgCDeB/uyxz34NgGVC9UIsU9m0KUZ8j83aziQPV9FfKLrdaLjgWsewS8wb550kf7nU6lMihUbfA49zJ6minUGflxW0OU/VGrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=c02LPeY/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490ac357c55so16717235e9.1
        for <cgroups@vger.kernel.org>; Tue, 02 Jun 2026 01:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1780389884; x=1780994684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EvSBfn8hnh3Fa3q9m3Os7/1FymexHNztWBt1PtbsT9o=;
        b=c02LPeY/BDYAGQwsRI+nWgcusO9f1O+x16EOPfjWYtTyJymSkFZwArJOJyCf/KmT2E
         Dn7H+44N1pYn4LZx0znsZwWRdj5vOnhhM90Llf5BkkLP0c/V/QOuwaLhy7D2KOR7OWtf
         n+aIwwUSqD92ebKuHFb/V+XqOJ9T22VKphflqu8gDhpP4nhTKC6ITcAdZdvmPcyZpoZm
         YHCAsWGX7t1zGdZWoOLg68yQgO833AvIA0cRa2Ior3W1HgiZLoIZyO/DnVi7AfYS/t9t
         nQVFKyG753rbJhU2ZMZ5dN3IRyTwusKnum1Cicd7af+JRcR1e5qbAg7fzgmt6Tz3rZjp
         Jtuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780389884; x=1780994684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EvSBfn8hnh3Fa3q9m3Os7/1FymexHNztWBt1PtbsT9o=;
        b=Xo9neD9sqI/ysE81bteaBDkBdILUfJzEc3mfO9t+FLoSxo3TzT7HNbMb5XONHYuw1G
         E4IDN5D3dJgeFoOc66N9O406RJldyVneFYa2ZW9ZbK3SbxMEcQn6mv5ZDC4MRPiEteWe
         C+TbqmvBk///P/tvTj2fYooRuOjUGNJonuiEgjbbLHzO/6of6cX6A5NqyGzgxjUugv31
         AsvTNpogsyAk2cG2MqyhL/hEGnMyKv3dHdz/2FUnERKdvE9ODuElOVNuYJ0ZW1uucch5
         2swUxP7sxiBq3OKPQ6X7lmdj/MCXmhG2rMrtk/kxX/FGwNw0uD04CjUrR5jeuLyZYpyk
         hdHg==
X-Forwarded-Encrypted: i=1; AFNElJ/wMqxyQinCiUXoASCTxxne3Xc72exDVmHisGGUM0fHb2TY8mrv7GfymhgeTHofWUeiznbhIndb@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfqe0n3uiPoU5a4V8zNprmoRQTpjKchqwYBBah8P+535KiDxH2
	ZHGIopgsOufm0S5U77RB6MQ24iDKb/jzatMlppIJgK+p0MKl4Qw+IaElWCD7ZKTvs1s=
X-Gm-Gg: Acq92OEUXrM/ZRzSr8kTi6YGB8hJN/G5EAK8mGlXFCiTyiGm3D87C43pdCtdZ9AFcOR
	dwxCKpbtmMVAIIpNZCdpQERWrIIKV9RExFmRoPgy/lcJmm6SH7LfHuzlCUzLadiNlXoi381Iez6
	nEPgyBOjF1bqB2w7O/67ByQoakGvA/LPWnd8ogwd8+iQzmgLfjR1kSpnNdobw4TCn0r2T9phs1W
	1Yc9t5/YmKE84k/f4Xz47CY1UblUsmcR1cuP0HoxqdMlJ+IBGR6cRzc2h1njUT/hlfxTe13/p2c
	/74Zj1FAGCB0OZxBa7CjVzyIH3hfjhUB2ZiDLvMZodaxIKft0oJogiqBWqC036baqyqqeSIP3xJ
	GEWvJx/AyVg/+yFw5zWontU0r6OGaePeIucDxU8lHJcRZquGTYSIDETjBFXnC0RQy6FWvsOKHzJ
	HE13j2SSoXaAfWar8bA9JNypDndbr+YjY=
X-Received: by 2002:a05:600c:190b:b0:48f:f64c:c2fe with SMTP id 5b1f17b1804b1-490a298f29bmr64095055e9.22.1780389883984;
        Tue, 02 Jun 2026 01:44:43 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c092:500::6:6dc9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b1006988sm22198595e9.5.2026.06.02.01.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 01:44:43 -0700 (PDT)
Date: Tue, 2 Jun 2026 09:44:41 +0100
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Yury Norov <ynorov@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Farhad Alemi <farhad.alemi@berkeley.edu>,
	Waiman Long <longman@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	cgroups@vger.kernel.org
Subject: Re: [PATCH] mm: don't allow empty relative nodemask in
 mpol_relative_nodemask()
Message-ID: <ah6X-RtVX75YP7VX@gourry-fedora-PF4VCD3F>
References: <20260528124133.c88c27b11a8ea0ef05e494f7@linux-foundation.org>
 <20260529152616.2308736-1-joshua.hahnjy@gmail.com>
 <ahnRIDBk4bQ3xX2q@yury>
 <fe33c767-ea11-43e2-8732-f752c9c1205c@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe33c767-ea11-43e2-8732-f752c9c1205c@kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16556-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,linux-foundation.org,intel.com,sk.com,linux.alibaba.com,kvack.org,vger.kernel.org,berkeley.edu,redhat.com,rasmusvillemoes.dk];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gourry.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4841C62ADDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 01, 2026 at 04:32:25PM +0200, David Hildenbrand (Arm) wrote:
> >>
> >> Thank you for taking a shot at fixing the bug report, please let me know what
> >> you think! Have a great day : -)
> > 
> > Hi Joshua.
> > 
> > Indeed, quick and dirty shot.
> > 
> > The problem is that nodes_fold() can't work with the sz == 0. In
> > other words, folding to a 0-bit bitmap is an error. We don't check
> > that on bitmaps level because it's an internal helper, and it's a
> > caller's responsibility to validate the parameters.
> > 
> > nodes_onto(), or more specifically bitmap_onto(), is a different
> > story. In case of empty relmap, the function actually clears all the
> > bits in dst and returns.
> 
> It's very weird that mpol_new_nodemask() (->create() callback) disallows empty
> nodemasks, but mpol_rebind_nodemask() (->rebind() callback) would allow empty
> nodemasks.
> 

Was this actually observed?

mpol_rebind_nodemask() happens when cgroup.cpuset changes, and
cgroup.cpuset cannot be empty.

cpuset only changes with sysfs twiddles or offlining.  In either case,
cpuset *guarantees* that cpuset.mems will never be empty.

So... is this an observed bug or just a statically discovered
"bug" that can't actually be reached?

~Gregory

