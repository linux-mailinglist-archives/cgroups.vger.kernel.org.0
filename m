Return-Path: <cgroups+bounces-16321-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INFKMnDSFWogcgcAu9opvQ
	(envelope-from <cgroups+bounces-16321-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 19:03:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D06B45DA4DF
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 19:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1FB00301C9D4
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 16:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC354028D8;
	Tue, 26 May 2026 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IrQshl4Y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oQ+fycG6"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E403403123
	for <cgroups@vger.kernel.org>; Tue, 26 May 2026 16:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779814752; cv=none; b=YurlzMjX34eKyVjFqRxuYg/k0oy0O1d9P9UXMrYuTcNGvBWjxKkit/S8BGoM9BYoRkxFisqDCyijmYjbOtN7OlbU9WCjurvRVx2YLTo7iI3tkMgs4pw0AfNruq6qkohtuYwybvJ+Lpkf5G4aRa6kbptt4JNP9Xc6axK+uctFqJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779814752; c=relaxed/simple;
	bh=Qu3cX7hp15/dx5l9QwIIMPC3NhQ0zgTS490oYVxhoJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCLKybfS2/O02Y+ktvS9SkLrq8NIY0q1hGpcJYiwHcA4V984XR0/uaF8bjOxl88EMLsl44WEA1i7COtHdM6D6iwcmmTNTgJfO4D2GwdTvfA/rZpg74i4tSpXpOq7zBSgeEinHcAkatyApmfPQ+mGkOuOMyMIjrTJoj4NiZAwG7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IrQshl4Y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oQ+fycG6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779814750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73qJRcIVQTUMp+UCzOKPBNoPdNKc7KyWvvJbngzri24=;
	b=IrQshl4YLBEKVQSARTc1lqzl/wPCM635kGALBBri5JNqMDQvMAAYmG241r4s74vZh4Pp9O
	qGwIiLdZdIOxQ8YI+HlfK8RlRPlCWWbsoquKZI+4lyn9zZWCxwe0m07f5pA/xSfz5gRsfZ
	nvPDjr3bTS+KKgj4k0dlLP4VjAA+wnk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-AlO8vXAyO8iFfAUkg-mUfw-1; Tue, 26 May 2026 12:59:08 -0400
X-MC-Unique: AlO8vXAyO8iFfAUkg-mUfw-1
X-Mimecast-MFC-AGG-ID: AlO8vXAyO8iFfAUkg-mUfw_1779814748
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-914b5249bc1so679175885a.2
        for <cgroups@vger.kernel.org>; Tue, 26 May 2026 09:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779814748; x=1780419548; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=73qJRcIVQTUMp+UCzOKPBNoPdNKc7KyWvvJbngzri24=;
        b=oQ+fycG6vge/XN5x6UArwwdDi8lLNOc77iVLsBK+Y9sFj3i+9d4DjuETJv8G+e11VV
         Nm5Y6AD2PfMCHj/y9tfGi2SsV799XE/PnZF4bNbqa9Ot/HkHOp0oTqhlHf+54+1qu4mw
         My0ORacKIjdbhHSbK7aE174okp3bL1FYtatUjEF2ysMsfP8sVgX2+EWbghVlOPjZOql/
         PGgCFBAIpPobmnZiQULQbxXVtSOD0uAnXAGiKcuU8hxFtdzVpUcmo+9iN2+rq5zx+s+3
         TZvqrwoqz0m1nmKN1x89Tl9OU83pFmEQItsMts6+QNGNgTbpGoPb2cXHPyF/WODZmje5
         SUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779814748; x=1780419548;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=73qJRcIVQTUMp+UCzOKPBNoPdNKc7KyWvvJbngzri24=;
        b=XZ73myuv0FbgIgciSacvkN5sKgmMwLxUPiUnFekts4csYxudvwI/C+CD2ivB/FnR1N
         DZPhTLFAEdxiSb0r71rjJ08tWji0OCflMxbezZP1TSDNfLkpFFZWvRuZcqxM+wRFa5Sl
         ZSiRclK0rYfpcCdIc/u9bo37roMb2yin6E30rgymWz79NX6i/PnC9nWvPCNEbnq9mvsi
         YUe/F8rDtqFx0j9o2o5O+t8nGX9p57INyLf8glw557PT4tweFWaaxC+FXYW1EJJdaehy
         hJ0iiikm+x+nNE2iIqQhJ1bMrPL7dkdwB1El/CwbXPRzrx/LmNr4LhhL7F7FISNmyCbm
         20Dg==
X-Forwarded-Encrypted: i=1; AFNElJ/N3yEGq9O4dCMKoUnJ5jkNUhEXlIbj9rqJ+nitt7q6uXhnrRURflPq6gLHbbdFVGrjPZ7Ttvyn@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/0YoZysY4rrf/lr1IiG6xq8p28WUao7NS96jFck6Q5ap63YZf
	J9ZOoNYdjktukXMw//id8a+uQqGT8s5T+KJ7804NcTyO8nhf80L+B6hWDqytO/17ymPRSf31yE4
	kXYYk/3sBJySZiCz4dxtlYt2ZQumVcINhzrhOcvcNeZwnFrbeuuf0IffBP7E=
X-Gm-Gg: Acq92OFk/2TTqh2EzywXXoVcAk0q1R3r6lFGjr9eHsWahVf+Oz3y1D8I/gRp04pCL5o
	mFdf+8rTpUegAYmMW14QkpnOUvviBgQ9S7zNUJDH2w2Ae/jZfIDnZVWY1r2CPPoYIJ2x31qMj2o
	nLHkNf2QBWQcsdrrZ802FqaqMWTbaKism3wFeCEYLP4F3ZTl5SWcJT4V+t1oK0r5zi4uX18DHsK
	GBp3iq7agrd9LDReXqkZm63FkHm+az6H7VrQVuJLc3VB4vHK0FqeDKzryeagcC8UDT/BGpjM0s2
	Jvw9ffETFJTZYnXn/3NlOZYvUSwPQCp3NBoLZKKjRWNjnlaTrV5uI1Vmn+1AEC2+JLJC+cMfCuG
	syivYaNI/Au3dT0HbBEBs8MjS4TnFhe4wFnohQ0jTrxqhiL8YnEULaEKqP0zW5jQo9Q==
X-Received: by 2002:a05:620a:2718:b0:914:c0e8:224 with SMTP id af79cd13be357-914c0e80a72mr2780659485a.54.1779814748214;
        Tue, 26 May 2026 09:59:08 -0700 (PDT)
X-Received: by 2002:a05:620a:2718:b0:914:c0e8:224 with SMTP id af79cd13be357-914c0e80a72mr2780650485a.54.1779814747523;
        Tue, 26 May 2026 09:59:07 -0700 (PDT)
Received: from localhost (pool-100-17-21-205.bstnma.fios.verizon.net. [100.17.21.205])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f8806496sm245054085a.38.2026.05.26.09.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 09:59:06 -0700 (PDT)
Date: Tue, 26 May 2026 12:59:05 -0400
From: Eric Chanudet <echanude@redhat.com>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
	Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	"T.J. Mercier" <tjmercier@google.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Maxime Ripard <mripard@redhat.com>, Albert Esteve <aesteve@redhat.com>, 
	Dave Airlie <airlied@gmail.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cgroup/dmem: add dmem.memcg control file for
 double-charging to memcg
Message-ID: <ahXKFYBdCMDBvc_N@x1nano>
References: <20260519-cgroup-dmem-memcg-double-charge-v2-0-db4d1407062b@redhat.com>
 <20260519-cgroup-dmem-memcg-double-charge-v2-2-db4d1407062b@redhat.com>
 <ahBxB5a9sX9DEWvl@localhost.localdomain>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahBxB5a9sX9DEWvl@localhost.localdomain>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16321-lists,cgroups=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,lankhorst.se,gmx.de,lwn.net,linuxfoundation.org,vger.kernel.org,kvack.org,lists.freedesktop.org,google.com,amd.com,redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[echanude@redhat.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D06B45DA4DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 05:26:16PM +0200, Michal Koutný wrote:
> Hello Eric.
> 
> On Tue, May 19, 2026 at 11:59:02AM -0400, Eric Chanudet <echanude@redhat.com> wrote:
> > Add a root-only cgroupfs file "dmem.memcg" that lets an administrator
> > configure whether allocations in a dmem region should also be charged to
> > the memory controller.
> 
> This kinda makes sense as it is not unlike io.cost.* device
> configurators.
> 
> Just for my better understanding -- will there be a space for userspace
> to switch this? (No charged dmem allocations happen before responsible
> userspace runs, so that the attribute remains unlocked.)
> 
> (I'm rather indifferent about the actual double charging/non-charging
> matter.)

Yes, this is intended to be configured before the user space stack that
would start allocating things is started. Once it has started (and tried
to charge something), the configuration is locked

> 
> > 
> > To handle inheritance, dmem adds a depends_on the memory controller,
> > unless MEMCG isn't configured in.
> > 
> > Double-charging is disabled by default. Once a charge is attempted, the
> > setting is locked to prevent inconsistent accounting by a small 4-state
> > machine (off, on, locked off, locked on).
> > 
> > The memcg to charge is derived from the pool's cgroup, since the pool
> > holds a reference to the dmem cgroup state that keeps the cgroup alive
> > until it gets uncharged.
> > 
> > Signed-off-by: Eric Chanudet <echanude@redhat.com>
> > ---
> >  Documentation/admin-guide/cgroup-v2.rst |  23 +++++
> >  kernel/cgroup/dmem.c                    | 158 +++++++++++++++++++++++++++++++-
> >  2 files changed, 178 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > index 6efd0095ed995b1550317662bc1b56c7a7f3db23..1d2fa55ddf0faa17baa916a8914d3033e8e42359 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -2828,6 +2828,29 @@ DMEM Interface Files
> >  	  drm/0000:03:00.0/vram0 12550144
> >  	  drm/0000:03:00.0/stolen 8650752
> >  
> > +  dmem.memcg
> > +	A readwrite nested-keyed file that exists only on the root
> > +	cgroup.
> 
> Strictly speaking this is not nested-keyed but flat keyed [1],

Indeed,

> which leads me to realization that this is the first instance of a boolean.
> All in call, such a composition comes to my mind (latter is RO):
> 
> 	drm/0000:03:00.0/vram0 enable=0|1 locked=0|1
> 

So per[1] 1 key, 2 sub-keys (enable RW, locked RO), that looks better
and match the documentation, thanks!

> 
> 
> > +static ssize_t dmem_cgroup_memcg_write(struct kernfs_open_file *of, char *buf,
> > +				       size_t nbytes, loff_t off)
> > +{
> > +	while (buf) {
> > +		struct dmem_cgroup_region *region;
> > +		char *options, *name;
> > +		bool flag;
> > +
> > +		options = buf;
> > +		buf = strchr(buf, '\n');
> > +		if (buf)
> > +			*buf++ = '\0';
> 
> I recall there was a discussion about accepting only a single device per
> write(2) (at the same time I see this idiom is still present in other
> dmem.* files, so this is nothing to change in _this_ patch).

I would second that. When setting say dmem.max for 2 regions, with a
typo on the second, the first one is set, but write still get EINVAL.

Also, I just notice dmemcg_limit_write() returns EINVAL if the region is
not found (this patch returns ENODEV).

> 
> Thanks,
> Michal
> 
> [1] https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v2.html#format



-- 
Eric Chanudet


