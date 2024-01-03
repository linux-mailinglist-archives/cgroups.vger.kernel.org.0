Return-Path: <cgroups+bounces-1057-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 750398229DE
	for <lists+cgroups@lfdr.de>; Wed,  3 Jan 2024 10:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DBCC285322
	for <lists+cgroups@lfdr.de>; Wed,  3 Jan 2024 09:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2560B18653;
	Wed,  3 Jan 2024 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jepADU8i";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jepADU8i"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A2C1863B;
	Wed,  3 Jan 2024 09:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F3EE421C97;
	Wed,  3 Jan 2024 09:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704272591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/wKVvKvm03UEJ1zWEiwuyaYFJhvNJ616HPYPBiI8YQ=;
	b=jepADU8iST6CjLUnRT9a6jAE+w0C5dLforvavtktIEjjD64Ml4ZI4pCqMYDuKtn059CLu/
	Aedew8aMfA4gaK07k1/8MawmuKIgqdLHrH3lX13QA2CXzb+WmxachkHtNme4ki0vHMzTUN
	XMjwx89DRMm9i3PPVglC7tHwiw/0sjE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704272591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/wKVvKvm03UEJ1zWEiwuyaYFJhvNJ616HPYPBiI8YQ=;
	b=jepADU8iST6CjLUnRT9a6jAE+w0C5dLforvavtktIEjjD64Ml4ZI4pCqMYDuKtn059CLu/
	Aedew8aMfA4gaK07k1/8MawmuKIgqdLHrH3lX13QA2CXzb+WmxachkHtNme4ki0vHMzTUN
	XMjwx89DRMm9i3PPVglC7tHwiw/0sjE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4B841340C;
	Wed,  3 Jan 2024 09:03:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CJ0gMs4ilWUcaAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 03 Jan 2024 09:03:10 +0000
Date: Wed, 3 Jan 2024 10:03:10 +0100
From: Michal Hocko <mhocko@suse.com>
To: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Yu Zhao <yuzhao@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	SeongJae Park <sj@kernel.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Nhat Pham <nphamcs@gmail.com>, Yue Zhao <findns94@gmail.com>
Subject: Re: [PATCH v5 2/2] mm: add swapiness= arg to memory.reclaim
Message-ID: <ZZUizpTWOt3gNeqR@tiehlicka>
References: <20231220152653.3273778-1-schatzberg.dan@gmail.com>
 <20231220152653.3273778-3-schatzberg.dan@gmail.com>
 <CAOUHufYwPzZ7k=ecFkxaw+26hUkiTODEnmKM8b3=Lk=n+bm29w@mail.gmail.com>
 <ZZQqCHmocwUFvuTz@dschatzberg-fedora-PF3DHTBV>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZZQqCHmocwUFvuTz@dschatzberg-fedora-PF3DHTBV>
X-Spam-Level: **
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.81 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:106:10:150:64:167:received];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLsgd6kpfonsu388crrfsk7e3y)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[20];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[google.com,cmpxchg.org,linux.dev,vivo.com,vger.kernel.org,kvack.org,kernel.org,bytedance.com,lwn.net,linux-foundation.org,huawei.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=jepADU8i
X-Spam-Score: -2.81
X-Rspamd-Queue-Id: F3EE421C97

On Tue 02-01-24 10:21:44, Dan Schatzberg wrote:
> Hi Yu Zhao,
> 
> Thanks for the feedback, sorry for the delayed response.
> 
> On Thu, Dec 21, 2023 at 10:31:59PM -0700, Yu Zhao wrote:
> > On Wed, Dec 20, 2023 at 8:27 AM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
> > >
> > > ...
> > 
> > The cover letter says:
> > "Previously, this exact interface addition was proposed by Yosry[3]."
> > 
> > So I think it should be acknowledged with a Suggested-by, based on:
> > "A Suggested-by: tag indicates that the patch idea is suggested by the
> > person named and ensures credit to the person for the idea."
> > from
> > https://docs.kernel.org/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
> 
> Sure, will do.
> 
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index d91963e2d47f..aa5666842c49 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -92,6 +92,9 @@ struct scan_control {
> > >         unsigned long   anon_cost;
> > >         unsigned long   file_cost;
> > >
> > > +       /* Swappiness value for reclaim. NULL will fall back to per-memcg/global value */
> > > +       int *swappiness;
> > 
> > Using a pointer to indicate whether the type it points to is
> > overridden isn't really a good practice.
> > 
> > A better alternative was suggested during the v2:
> > "Perhaps the negative to avoid unnecessary dereferences."
> > https://lore.kernel.org/linux-mm/dhhjw4h22q4ngwtxmhuyifv32zjd6z2relrcjgnxsw6zys3mod@o6dh5dy53ae3/
> 
> I did have a couple versions with a negative but it creates
> initialization issues where every instantiation of scan_control needs
> to make sure to initialize swappiness or else it will behave as if
> swappiness is 0. That's pretty error prone so using the pointer seemed
> the better approach.

I do agree with this. Especially for an opt-in features it is better if
the default initialization has a clear meanining. In this case even if
somebody doesn't use the helper then the NULL should be caught as NULL
ptr rather than a silent misbehavior.
-- 
Michal Hocko
SUSE Labs

