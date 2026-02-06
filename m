Return-Path: <cgroups+bounces-13744-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Jk9EuUGhmkRJQQAu9opvQ
	(envelope-from <cgroups+bounces-13744-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 16:21:09 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F67DFFAD7
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 16:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 53E03300516E
	for <lists+cgroups@lfdr.de>; Fri,  6 Feb 2026 15:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA85298CC7;
	Fri,  6 Feb 2026 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZQ9RseS"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA512367B5
	for <cgroups@vger.kernel.org>; Fri,  6 Feb 2026 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770391258; cv=none; b=PPnDwgPgZQwwUtZFFd4M20wUcBwwE53/n+zEb4n01eAXAwp6ByGw8KzKi4vyKGQ8E/EIjFcTCZmqcWPp69ACYG5qCnPWS20UXc7i3CSgCmDgznWzJ08TTIkUuj0ZF0ewnmXRm9nYhjs0aqIo1rKgcm55Wj9Ue5YoovDf50UIc9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770391258; c=relaxed/simple;
	bh=m9TLokuC5rGVZdojl+bDurZF6xBfwIKD9MiN3qlHtRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+ozdkzm02CDOOF492z2jHDlfIJ6Yudo+VdEvq2f9OshII13+ot6jUUYyg968b7CACpLEaK1WnP6sEAmsf9nKkZbXqhSX6LCKmo/ivwlf20uJfopE9TNT+Eh7XyPMw3aTRsFo9Tc+rlgCqg5qRTz+3majnMAAuJ4+jFOY0zCFxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IZQ9RseS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770391257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m9TLokuC5rGVZdojl+bDurZF6xBfwIKD9MiN3qlHtRk=;
	b=IZQ9RseSZVIezVj/G95DnKlGMareumtSDH074/z7OpOmGWttd9gaXtK2G0CxgLVoovDcVT
	HR0GGW/+/7Z3W1Ge8TsGWxka7FSGovvklbIrViZCfDRFylXPY/OrJyMOc/eLxEdpJWiO+a
	haKqRp3x9Ds1vzK6ZgPX40crAJybrsU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-ECvfvB9IP0O8Uukw_JZm4w-1; Fri,
 06 Feb 2026 10:20:54 -0500
X-MC-Unique: ECvfvB9IP0O8Uukw_JZm4w-1
X-Mimecast-MFC-AGG-ID: ECvfvB9IP0O8Uukw_JZm4w_1770391251
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C61B1955F12;
	Fri,  6 Feb 2026 15:20:51 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.22.74.16])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6DC6B18003F5;
	Fri,  6 Feb 2026 15:20:49 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id CADA64015C638; Fri,  6 Feb 2026 12:20:28 -0300 (-03)
Date: Fri, 6 Feb 2026 12:20:28 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 1/4] Introducing qpw_lock() and per-cpu queue & flush work
Message-ID: <aYYGvEkIwBiRR1Uh@tpad>
References: <20260206143430.021026873@redhat.com>
 <20260206143741.525190180@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206143741.525190180@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13744-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,linux.com,google.com,lge.com,suse.cz,gmail.com,redhat.com,linutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mtosatti@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4F67DFFAD7
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 11:34:31AM -0300, Marcelo Tosatti wrote:
> Some places in the kernel implement a parallel programming strategy
> consisting on local_locks() for most of the work, and some rare remote
> operations are scheduled on target cpu. This keeps cache bouncing low since
> cacheline tends to be mostly local, and avoids the cost of locks in non-RT
> kernels, even though the very few remote operations will be expensive due
> to scheduling overhead.

Forgot to mention: patchset is against Vlastimil's slab/next tree.



