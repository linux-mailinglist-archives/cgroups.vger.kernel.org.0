Return-Path: <cgroups+bounces-13865-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPTyMmi3jGnlsQAAu9opvQ
	(envelope-from <cgroups+bounces-13865-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Feb 2026 18:07:52 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8D01266CA
	for <lists+cgroups@lfdr.de>; Wed, 11 Feb 2026 18:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 102AD3013A42
	for <lists+cgroups@lfdr.de>; Wed, 11 Feb 2026 17:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EADD3451AA;
	Wed, 11 Feb 2026 17:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bTr9enjM"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A29F2C11D0
	for <cgroups@vger.kernel.org>; Wed, 11 Feb 2026 17:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770829642; cv=none; b=F9Mg+moJ1O3U9VZPYOArXzWTecoQXtfHu3gX9ENMxhXLzOwHM2ihP8wV+3ajUP30VzshgGlDyK5Ds/5KfjQ8WegJL/j38SB+0HeZZxQFv7NgEbOsuuBJS3fuQd7UP/aDOVE59bqIRYPjuF65/g5PpCS4jziHuko7NT/2XAtjrJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770829642; c=relaxed/simple;
	bh=ySVPfXbmJnp2WBkqN8BJ9diFQawVwKchKNh2lAXXJm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnaw4xKUC31w5cwNt2ei9v9YrSmUe65qxIGE3QOUkWE/dyIQvwhKUT4U1kau02H/KrDBGPE+whzJXJBKj2BXdDlc8LKhA2tKQwAOZcctO/BI1xbqNj0h6njX1GKLLr2Yj+PJfYmxW+iJ9G53nFTxfGVyMjs5UkoWA1Qmq/X1yVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bTr9enjM; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso11408305e9.1
        for <cgroups@vger.kernel.org>; Wed, 11 Feb 2026 09:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770829639; x=1771434439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mPSBc0UQSAHkKnCaf7ezAsL21Xf876MMmDqC8iH+97k=;
        b=bTr9enjML4h4on8PV9vEiZNZbYCH29avG+maXFoQqWjtGuq4xmkkKvXllnumhLvwOh
         hM+vdPNxhQf+koO20no9e92MVfkh9vpi9ZI4etPV1/3KtkvuOiUkygTB56qCm6pPpBD4
         0gtHkJtvBr2OHIdlkV3e/9ZKz+QIpo51g5sBCjYgxjWjh2f42506s8byTKioUHv5GgyD
         dGUKPRH93bJy4HEjHOieuJEjdJc8akVWNEMiR6Z8bNvtpyiigNljEmenQU5LDvsytbSp
         eADA/Wcte7wXjfEEfw4djbKL3nPSBihkN+Y0hjeWCA0voQwmC5qcZ+GgIOI0FeTdQuRf
         uigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770829639; x=1771434439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPSBc0UQSAHkKnCaf7ezAsL21Xf876MMmDqC8iH+97k=;
        b=LHyfB4DezAp3ihnUm6mG4G9WJqZohZeWIj4JaYH/MwXjL69OoZy/qPPniktoZ88xXv
         z0aIgASvgvPGnZfcGIE72fuSy92VyvZbEDBBZOCH+kFL44XSXHp0GqwbreF4Tmkg6fSw
         s1YMqEyERFBjiPQQP08HBZGHZ0+Lru2q6vOH7Vhl8/OrPJ4LahMmY7AOEX0UCSgF4JHp
         W4bnP3HxnfM5HyKl/bNBQJQMcuRmuw36cuLoOV3Gxf63rUP8iOXpElQrU8c7Ipa4MsQ0
         zmqF+z6AJJDL/RuOpXaB+Bu8osgRJZlMUea5aN3BCabtfFlVoRdNmbX3jhe8dhs3o3KW
         z8Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXnM8Qg4SfEa1LTZ8zHt4NRyy19ZZiNG6N3k3zzgiauQVEObXKxB6c+pSMdATEnpRpUfB1ujm4Q@vger.kernel.org
X-Gm-Message-State: AOJu0YyWT4yBZjniBeD7CiZNODznKeXi0KmCHmWJNtmOxLIjS3IUxt9K
	P0322lu7pjFuRgEBysq/Wq262oNsytQlY2/Pyo8PjbHwNNG8P6cRer5ikV0ItiO1Njc=
X-Gm-Gg: AZuq6aL0mGIdB4UiAgenzA99b8EZPkn91PcAd5bXv+GK2RK0FKcN7wDg1VWpXTk95AQ
	CqFmAJQjkw2/XvQk3NZaLi+t7w2SNDblWdX5WW7Kc+VKI5Hrii+MFQoc6TOEfVn9HoytiMbN1py
	ka4aHmb1EZnO6OvVR+gt+pRtqkTVMq5HnBshl/om6OI5a2GybY1HfnuyubY04evGQ/X13mku59Y
	AFV4Ge4mNHgftsV+q/Is+f2sLy+9avXc7DuiL0K02xcJE32LSOKhojkMgSAA9IpPAB608nLIH7I
	KjZfBnrByIsIjRJyUPBfAjIxQpn4O13Sjg5rZWb9nlk58nJX2IKVHge/bqkcWHOZTi6pIZLXDr2
	3d0wf1rdruWK8+yk7FGIddikxJLzHGFBj5kz9+dqz31r3lFmkerT7WJjL4Ak7OewKIXJ7TWdHg/
	LycxLc14rnMg6dGH3XpoybsfNn/x8cKnlMg2st
X-Received: by 2002:a05:600c:524e:b0:46f:a2ba:581f with SMTP id 5b1f17b1804b1-48365057efamr1621985e9.16.1770829639376;
        Wed, 11 Feb 2026 09:07:19 -0800 (PST)
Received: from localhost (109-81-83-241.rct.o2.cz. [109.81.83.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5e0ed5sm130603715e9.5.2026.02.11.09.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 09:07:18 -0800 (PST)
Date: Wed, 11 Feb 2026 18:07:17 +0100
From: Michal Hocko <mhocko@suse.com>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Frederic Weisbecker <fweisbecker@suse.de>
Subject: Re: [PATCH 0/4] Introduce QPW for per-cpu operations
Message-ID: <aYy3RdKQF_aTErzB@tiehlicka>
References: <20260206143430.021026873@redhat.com>
 <aYs6Ju2G4bm6_tl2@tiehlicka>
 <aYxviLoWsrLqDU7o@tpad>
 <aYywl1hdBQP2_slo@tiehlicka>
 <aYyzZbh/YRMDcviS@tpad>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYyzZbh/YRMDcviS@tpad>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13865-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,gmail.com,redhat.com,linutronix.de,suse.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim]
X-Rspamd-Queue-Id: DA8D01266CA
X-Rspamd-Action: no action

On Wed 11-02-26 13:50:45, Marcelo Tosatti wrote:
> On Wed, Feb 11, 2026 at 05:38:47PM +0100, Michal Hocko wrote:
> > On Wed 11-02-26 09:01:12, Marcelo Tosatti wrote:
> > > On Tue, Feb 10, 2026 at 03:01:10PM +0100, Michal Hocko wrote:
> > [...]
> > > > What about !PREEMPT_RT? We have people running isolated workloads and
> > > > these sorts of pcp disruptions are really unwelcome as well. They do not
> > > > have requirements as strong as RT workloads but the underlying
> > > > fundamental problem is the same. Frederic (now CCed) is working on
> > > > moving those pcp book keeping activities to be executed to the return to
> > > > the userspace which should be taking care of both RT and non-RT
> > > > configurations AFAICS.
> > > 
> > > Michal,
> > > 
> > > For !PREEMPT_RT, _if_ you select CONFIG_QPW=y, then there is a kernel
> > > boot option qpw=y/n, which controls whether the behaviour will be
> > > similar (the spinlock is taken on local_lock, similar to PREEMPT_RT).
> > 
> > My bad. I've misread the config space of this.
> 
> My bad, actually. Its only CONFIG_QPW on the current patchset.

Yeah. PREEMPT_RT -> CONFIG_QPW=y and cmd line makes no difference
-- 
Michal Hocko
SUSE Labs

