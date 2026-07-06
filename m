Return-Path: <cgroups+bounces-17539-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GuNRFz2sS2pDYQEAu9opvQ
	(envelope-from <cgroups+bounces-17539-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 15:23:09 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B7371134A
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 15:23:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=CxSA+Lc1;
	dkim=pass header.d=redhat.com header.s=google header.b=f3K6Jtan;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17539-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17539-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46822305C6DB
	for <lists+cgroups@lfdr.de>; Mon,  6 Jul 2026 13:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CEC40A92C;
	Mon,  6 Jul 2026 13:16:05 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB58C372663
	for <cgroups@vger.kernel.org>; Mon,  6 Jul 2026 13:16:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783343765; cv=pass; b=j8TIZ/IMRloweOUYfu01jUQLe7mo4Gk4LIW6gtQMEcuXmCAghcgsKJ+In/xM124UDfRiP9Nr1keehUJKXwmGbWjIouH0Jbum+PrbYLrWXrMoHEsCmt2DLs0UEmvj5z+c5NzwR7eZDm5Mj21lHEZndhmF2lxC4UMmcrtEL0184vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783343765; c=relaxed/simple;
	bh=ZG4slmePuA8hAwfYnmF/1n5HJkJeLXV2KFDHoBeiAmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=STN97/KnIGF31sP/Kv8rkKskDiagg8m5vypuFdcjfHCx+dIx1wNGDprVaCOKQLyaz8K12igZkLDIm2YFkS+XI1lpbJvFJYc+9pgW19Qpk+iSSRboU0eT11TREQICbyO1ln+BNgB3Z525E2UmZQK1ZYP2WgbImahhZk7vhjN0uaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CxSA+Lc1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=f3K6Jtan; arc=pass smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783343763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AxMOA32PrhBgJC1rEErLDcIUQtikuP/rNGrPj73qrKE=;
	b=CxSA+Lc1ttmV6E3ihZHLeSTzE87AL/TAUAhffhYqZBQrOqVfR4kV5aaMb2jC2ihvtEIlRs
	UfKxj9MsrHi9qR+PKUpq7EJNUhuccd4stO+bP792h/ywbYjxEy/AaJO4FJDCoHSovACndl
	+vqldmk868fRcC/z/pctQbtaGJcEXQk=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-KGfaxJ7OM4OmmZDQ4Xp4YQ-1; Mon, 06 Jul 2026 09:16:01 -0400
X-MC-Unique: KGfaxJ7OM4OmmZDQ4Xp4YQ-1
X-Mimecast-MFC-AGG-ID: KGfaxJ7OM4OmmZDQ4Xp4YQ_1783343761
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-6652046121eso6063832d50.0
        for <cgroups@vger.kernel.org>; Mon, 06 Jul 2026 06:16:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783343761; cv=none;
        d=google.com; s=arc-20260327;
        b=me8Hx/kzWeoHKZiP/j3n8pv9XICM6gi2d5qUDC5c5C1+o0I3Uc6s3BIMYA12DQkiYO
         Lzk9NsrKBtuZl/zgliU9bu9s7IrGZzN8XJc2mUjIq+DdkFP3FmVLPZtnRi/PKZqde1dx
         Hxu5LrfRpsz6odssAVksHDCJKHZbhcj0DSMV2Wycqg3LdZktO82FJcK03+9C2avzvxdt
         gX0Quy8z/hbOkP25VZuSbR1+kVXbbDetGgloqd9SlunWAL/HJLVlrjmVB6kRsOb1TQ2w
         DERYtYesEAAGyBreVoZZs2wg+omG8c5M++CXx7jIr1r+7mLrnTCfDyrmrTF4ErbruHRu
         l2mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AxMOA32PrhBgJC1rEErLDcIUQtikuP/rNGrPj73qrKE=;
        fh=0brJsvj1fX16fAaKY+8l+7MXtVC5jUjtlFu9iaIG+6o=;
        b=bFC3I/2NtSViEDu6JckDWm/I0j4+YV5kzq8ikPFFPcutT3a52YkFVNBo3MKJ5hZ2PI
         hBA3tJOF//kMHvN8FZBuZrUJfhaSgCXG72rCJa1FZttmNDb9fFN4XMITeSpsHwu7EqKW
         KLO9UBnrX6MbSjyfoXlt/iLXv0l4zZ4Qig6boTY4IHkkpPZoyR4n0oSK+DwB6/WUDPlk
         cBq5wLfXhpODME3Bwc8YofxkLu6Jq/1I7xLeTNzVcK2VvtO3N/f0NI1MlW8x6Cg7EdU4
         vatfpSdcZAYiagZHErN1t07fOrG5rzfMZya6Xz+anSkOxTX4wd0cwspD5vqGX6DcBJyy
         pjZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783343761; x=1783948561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxMOA32PrhBgJC1rEErLDcIUQtikuP/rNGrPj73qrKE=;
        b=f3K6JtanNgJILT3uUd5Ns5F6a/HpxST2yALn4yZ8Lix/FKn1ujbu9sGfoS423cym3T
         +Bf9peWZMif98A5vl49Q91m0qXy1i8MngpA0+aPMEOf2OdPKi4QbndK4ti+C19ofqzUY
         uNlGCgIXgt3QEV+YxZsSLtiCR3wXKPe/Alo6rChn+7aKleuqGdVnpjj6l2slNeg6ClPo
         kA0rqNfWcaYQdfJ/u63uFsy3/q1RW3nuPtQT3oM3nT1eafHIgxgF4HOQ5tazb7Qc+gQN
         jH9HrvnXA2rWfginu9fNo+kLd/0OqCchRd8nPSfx5MEJDalpSkaVoLw0kstiXDhhh7XF
         4RTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783343761; x=1783948561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AxMOA32PrhBgJC1rEErLDcIUQtikuP/rNGrPj73qrKE=;
        b=B6D+3csnbpXlLS1zSbUmSW+h8IXrcj352OmvVS9FfeKqxHAxaAr5xFQeUKM3U18UXK
         +7PivHkapYJt38ZlYAY2P0o3wKJcqs3TVKMieil35Z+rOJhbJlN7RCppmlh5eYd7J2dw
         hVzMsAIXcvTQkzwmXN1LT4TTB0bT+J+d5vBExzJFbPEE+0Zh7/q3lHQ48H0bTxyG/pdf
         WecXEamN7FN5KDr6ZGT7e1iLy37m38k6HX7ta1HYZoqcLDRytosL261DzsODC7DnFeQ0
         AvVd+TybqdPOb2LdwKQfSlNcdK7f5HMDV6rpPdMFQsUxgbm1CASUCYQNy1zPlrGFacJo
         +pzA==
X-Forwarded-Encrypted: i=1; AHgh+Rry6h9sLxZQxS0nA3qu16GEDRCvdxAvU389lJE0FfGom/dRjX7uDl5440BVlmjuP2wAdrtop8Ge@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/NIApu+nl2VQ4GdwZpabQ7jc6FuVa0o4S223BBcAvx6uOQsyc
	oCGB6ih6TgaQnvW11143bqTLDVHnNr26PRm8Fme8f6iG0xb/T+0ODWxirWSECSeH3OBlkOo/DVm
	dqDh7weJoExdy/QLAMCMM1C3t50vMlMLJ8zxEU/yR3gflcR3fIJ0uBOj7GuR//mF+ru7HWP8CaS
	d1PSLg4X0bN/IATdE4NVhik9QUIUH7TIlscQ==
X-Gm-Gg: AfdE7cmwYvKo8i2wEok0z+75yYuOimi0Qc9IRYtFS1D/6bmUZsXVBxgyR7RDKSjdL2o
	CM4VXrAui/GHX8gMe1DiLx4R2ZcxnBdctZfzZN2qeUGdzrS8Im5VvmIpgxRB++3eFjsajs63dky
	Ms5seosy4H6rzRBfj/NJMzl7GqrGXsXvh8xMWOLfR7OpEQ4xcUgG0Ly7d5gRlth5ESq2QcXCJod
	ULL4E4iuQ6rD8+7ohDKoTGsJtWnWIA1982hx45NE1XWUOebnFaRabQ=
X-Received: by 2002:a05:690e:2027:b0:666:53bb:bc1f with SMTP id 956f58d0204a3-6677fa5a3efmr346419d50.1.1783343761032;
        Mon, 06 Jul 2026 06:16:01 -0700 (PDT)
X-Received: by 2002:a05:690e:2027:b0:666:53bb:bc1f with SMTP id
 956f58d0204a3-6677fa5a3efmr346388d50.1.1783343760532; Mon, 06 Jul 2026
 06:16:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHc6FU4tz8-HmEf2_XKT0NT8N=rv5OMcY79PxTACkXAVLOAUpg@mail.gmail.com>
 <akZEjH2Hf8-RR8yQ@infradead.org> <akhaWrUHXcubQQab@casper.infradead.org>
In-Reply-To: <akhaWrUHXcubQQab@casper.infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 6 Jul 2026 15:15:49 +0200
X-Gm-Features: AVVi8CeZ90TZOgMX_QaiF2EyLUwZK6uqeXE5eQFowT0YnNBZfC21D0pOzkVqfoY
Message-ID: <CAHc6FU4-GsE1jtw8kXe0h_-T6VK2bB5QuVm2w16Ek6FiUV77tg@mail.gmail.com>
Subject: Re: iomap_writepages WARN_ON_ONCE(PF_MEMALLOC)
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, gfs2 <gfs2@lists.linux.dev>, linux-xfs@vger.kernel.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17539-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:willy@infradead.org,m:hch@infradead.org,m:brauner@kernel.org,m:djwong@kernel.org,m:gfs2@lists.linux.dev,m:linux-xfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:linux-mm@kvack.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER(0.00)[agruenba@redhat.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[agruenba@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A7B7371134A

On Sat, Jul 4, 2026 at 2:57=E2=80=AFAM Matthew Wilcox <willy@infradead.org>=
 wrote:
> On Thu, Jul 02, 2026 at 03:59:24AM -0700, Christoph Hellwig wrote:
> > On Wed, Jul 01, 2026 at 10:51:06PM +0200, Andreas Gruenbacher wrote:
> > > Do you have any suggestions?
> > >
> > > The above is on RHEL-8, but a similar code path exists in cgroups v2,
> > > triggered via:
> > >
> > >   echo reclaim_amount > /sys/fs/cgroup/.../memory.reclaim
> > >
> > > That code path starts with:
> > >
> > > memory_reclaim -> user_proactive_reclaim -> try_to_free_mem_cgroup_pa=
ges ->
> >
> > PF_MEMALLOC is a sign of direct reclaim.  cgroup code is doing really
> > weird things when it is set and it is doing writeback.
>
> If we're going to blame the cgroup people for doing weird things, let's
> cc them so they stand a chance of seeing this ... original at:
>
> https://lore.kernel.org/linux-fsdevel/CAHc6FU4tz8-HmEf2_XKT0NT8N=3Drv5OMc=
Y79PxTACkXAVLOAUpg@mail.gmail.com/

This is all pretty ugly: inode_lru_isolate() selects inodes that have
a clear i_state to evict. Among the inodes selected is at least one
gfs2 inode that has the GLF_LFLUSH glock flag is set in
GFS2_I(inode)->i_gl->gl_flags. That flag means that evicting the inode
requires flushing out revokes. Before that log flush can happen,
ordered inodes need to be flushed (ordered journalling mode). And this
is where iomap_writepages() got called.

Unfortunately, filesystems cannot refuse to evict inodes once they are
chosen by inode_lru_isolate().

An acceptable way out may be to set an i_state flag whenever the
GLF_LFLUSH glock flag is set so that inode_lru_isolate() will skip
those problematic inodes.

Thanks,
Andreas


