Return-Path: <cgroups+bounces-16799-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IIVxGGAwKWqVSAMAu9opvQ
	(envelope-from <cgroups+bounces-16799-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 11:37:36 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF724667E74
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 11:37:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="LtZtMMV/";
	dkim=pass header.d=redhat.com header.s=google header.b=P5XbKeil;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16799-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16799-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2225D325608B
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 09:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521373DB634;
	Wed, 10 Jun 2026 09:21:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63F83AD50F
	for <cgroups@vger.kernel.org>; Wed, 10 Jun 2026 09:21:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781083306; cv=none; b=CA9xoR6x5dHYvxWyoi8TxY8Nkd22gLjpjFF4ZjgInoQnCKJsJevbRWhCsvXX2WbaOsB6XuG13W3M7qBD7h6UkJO3vsx+ZsoLP0woQY5L+PsadoYY75GTk/6F4+dA/1WDnn5smmkKJPJ9TpdqrsLIzJ5vj5v3LFixO9jd7ZuidBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781083306; c=relaxed/simple;
	bh=g5+W+jLy9btQjSDtxGia7H7MJP8ofhpJzo3kG4SNk7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svTo4IrU60C3yDzvWik1X1oLI36aFncAuEvNQZNTdmrzl3V+zOXANgvXQNOXh+BkeJtllstFq1TlLk2eVYyliWHLVwtLU5/MHiQu7TI1jOqyA9yJDGYY4mLYIDhlMj4xwBcyQ8etNGwdCN/ADF3uk4Uu+N0JJfYeMH72JvE2Yxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LtZtMMV/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=P5XbKeil; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781083304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lNoSE7CdhqapQyjtlFSi1j5OlaFx/mTNFdn28cYSfbk=;
	b=LtZtMMV/57cxUznwAX3QOB4CzsNS+NxCIQ0vBnJorh8YI3aY0PAdbG75fRlxk30ftN7BfC
	wjwdZS97SLcu6jZE+MJJkOvu8iLf/wOQuy812JMFZhBRM6SRWIR3rMIVC4MZlWTnLqJhiZ
	e4GkRnsFIhEuwGAHcrKW7s+1N/68aUw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-dop2_b5GOx-SbReaA8snaA-1; Wed, 10 Jun 2026 05:21:42 -0400
X-MC-Unique: dop2_b5GOx-SbReaA8snaA-1
X-Mimecast-MFC-AGG-ID: dop2_b5GOx-SbReaA8snaA_1781083301
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490bae3a39bso7925625e9.1
        for <cgroups@vger.kernel.org>; Wed, 10 Jun 2026 02:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781083301; x=1781688101; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lNoSE7CdhqapQyjtlFSi1j5OlaFx/mTNFdn28cYSfbk=;
        b=P5XbKeilyj6PjLc+j+bms2IePvgNd56oDnGCmNfcJBF4RytKWmPGWnFYUa9ewS/Gy8
         CTG8FtAQzWymwV+Ioc3QBe8jS8XbG0w5vFHwUBNutXIk0YBEzvg+7iIX/t5aq7vohXPx
         ADMiKKpZPRrvx9w7NKWpeuTxAOuaGPKxi4K3Ngg4+OkzCvvoX/lxLLdrUHlVKd2plvmT
         DhpgQVA6O8IrHXy4El2L8hWSQaXF1jtx/aMp+hMiyYWOXECF3u6rLJYIEHrcBb0ySwJs
         2KS4jXeuDpPBgjM9lxoVHuhgMEFE8mQoMiObTkyh8b7ssCHio5ZDvONLldsI29CI0ykB
         rISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781083301; x=1781688101;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNoSE7CdhqapQyjtlFSi1j5OlaFx/mTNFdn28cYSfbk=;
        b=QT+a7g4kKcT+jG6HOCbAoSwWbJXlSHutAGIOGL+ntZS6KXePHKwMMKhJAL801FqPpK
         IEuLgi8nMGhwCmsKZK5/xWqXG1WCwBv//gMUDuR+PKLX6W2w8qUHVQWUlCCMdmqQ9Tl4
         7FfCRiSQ2vNPfqS1NG7RVBNzanvFtPt1oWJ644a+3BOo7LLh9FpPMXGgFzhJydC/sp17
         TKOCI0OPCuhmU51cfWHYcGVzB6L8OMSGfQ4MJ5eSrqbH6VmtTx4J9C/XmqqBpjOV3YbL
         vX1M9hXEY6YnXwQ4uuqMLiqkA4FvQr80+gaE3pmJO+isSjK3p8AQ/z47WNIAtqNixuGa
         uBeg==
X-Forwarded-Encrypted: i=1; AFNElJ+O+5rn9/cUEuSzzZvq5CwioDs6KDOVfirHKFWe5sRi4AnPs6HFJH+uo1MfhhJou8LEDoGgLkCh@vger.kernel.org
X-Gm-Message-State: AOJu0YyMAQpegUs3ljuCAvFGbsGyRqUvItLsMSVKU/2yf2H0kw8l8zga
	88yYckOwpXGJ5m9Oxz6kn7D3gi3+TehbTNwzl8knNOkaNfsBsyJuidAA6IAfC6Xcx/P05R6A6rY
	rcNm2YPWrDVG7fQfX9XyHOTki4aQjxlPiEfrtptSGSdafTORLHR2aRKaVFBs=
X-Gm-Gg: Acq92OEwgMNNS2J/+KgOkJY+eNPFosYF/kG4F7QOYSEiD5oHR7iodC1TC3EIpr/tZ5I
	SWP/EQ5Onhuo5PhdfFvTBFk1JjlX0tIE7AzucWSofmom2NL8N6b8z8rBIt0Hg4gY5TQaFtrRZ7U
	XZuD9tLMhY/6mypLivk3FJhf+6J+XTS4bVXlPCxxDBZzkEWg5P8y7Nvve8wjur5dCUQ9wuWSM9U
	rWCfjJeMtnfPWUrWQFv90vEZO95uHwCRbCjCdU1ECpYdlT5YeK9HO7IudAluAg2PgEclgItRTM7
	3dBuw96c+xlxe5q9FITbO2XHOAqrlhRnRIJ3gLQjICKQQYCvpDKLb5aMIlkOiv1vdM+pOLLFmKK
	MDwV476eGQC7tGw1g7vRMtHjidG7YRc71bG5dGpr9Ll+U8vHOMFTgSg2+nNx4X20=
X-Received: by 2002:a05:600c:1554:b0:490:7dfd:f7c2 with SMTP id 5b1f17b1804b1-490c25eaca1mr406762885e9.11.1781083301123;
        Wed, 10 Jun 2026 02:21:41 -0700 (PDT)
X-Received: by 2002:a05:600c:1554:b0:490:7dfd:f7c2 with SMTP id 5b1f17b1804b1-490c25eaca1mr406762205e9.11.1781083300690;
        Wed, 10 Jun 2026 02:21:40 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.95.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35eae5sm70938593f8f.33.2026.06.10.02.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 02:21:40 -0700 (PDT)
Date: Wed, 10 Jun 2026 11:21:37 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yurand2000@gmail.com>
Subject: Re: [RFC PATCH v6 00/25] Hierarchical Constant Bandwidth Server
Message-ID: <aiksoUznUgTMUgXX@jlelli-thinkpadt14gen4.remote.csb>
References: <20260608121546.69910-1-yurand2000@gmail.com>
 <aig1ZGEq0Vr0qLzl@jlelli-thinkpadt14gen4.remote.csb>
 <9c0d3d19-5c14-42e0-b29d-4ea32d9e624f@santannapisa.it>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c0d3d19-5c14-42e0-b29d-4ea32d9e624f@santannapisa.it>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16799-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,cmpxchg.org,suse.com,vger.kernel.org,santannapisa.it,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[juri.lelli@redhat.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:yuri.andriaccio@santannapisa.it,m:mingo@redhat.com,m:peterz@infradead.org,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:luca.abeni@santannapisa.it,m:yurand2000@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[juri.lelli@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,jlelli-thinkpadt14gen4.remote.csb:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF724667E74

On 09/06/26 18:23, Yuri Andriaccio wrote:
> Hi Juri,
> 
> Thanks for looking into this.
> 
> > I started playing with the new interface and ended up with the following
> >
> > bash-5.3# cat cpu.rt.max  (root)
> > 10000 100000
> > bash-5.3# cat g1/cpu.rt.max
> > 10000 100000
> > bash-5.3# cat g1/cpu.rt.internal
> > 9999 100000
> >
> > which looks odd to me, as nothing is running on g1 yet and no children
> > groups either. Maybe a rounding error of some kind?
> 
> You are right. I should have mentioned that it is just a rounding error that
> occurs when converting from a bandwidth value to a runtime value. This
> happens because the tg_rt_internal_bandwidth() function truncates the value
> when transforming the runtime from nanoseconds to micros. Rounding could be
> used here to report a more accurate value.
> 
> This same issue is probably found in the from_ratio() function, which has a
> similar truncation issue when converting from bandwidth to runtime, but
> since it is working in the nanoseconds range it might not be that big of a
> problem. The value from from_ratio() is used for the setup of the dl_servers
> even when the children bw is zero, so maybe it is possible to add a special
> case?
> 
> Anyways, as it is right now, the cpu.rt.internal may have only a +1/-1us
> error in reporting the actual used values, while the error for the runtime
> value used internally to setup the dl_servers is in the range of tens of
> nanoseconds.

Not a huge problem per se, but it will raise some eyebrows (and generate
questions) if we leave things as is, I fear.

I wonder if, instead of converting to bandwidth ratios and back (losing
precision in both directions), we can compute children's runtime sum directly
in nanoseconds. For children with different periods, we can maybe normalize
(128-bit intermediate?). Parent's internal runtime is then a simple exact
subtraction: parent_runtime - children_runtime_sum. This should reduce
precision loss from double conversions. Also, as you suggest as well, apply
rounding when displaying to user. 


