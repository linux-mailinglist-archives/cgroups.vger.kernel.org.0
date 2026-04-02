Return-Path: <cgroups+bounces-15165-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDgVHd1DzmlQmQYAu9opvQ
	(envelope-from <cgroups+bounces-15165-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 02 Apr 2026 12:24:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE38387AC8
	for <lists+cgroups@lfdr.de>; Thu, 02 Apr 2026 12:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF6BF308833F
	for <lists+cgroups@lfdr.de>; Thu,  2 Apr 2026 10:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF4F3DE435;
	Thu,  2 Apr 2026 10:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxhVT7de";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kNRjvj9y"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEA437DE88
	for <cgroups@vger.kernel.org>; Thu,  2 Apr 2026 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775125207; cv=none; b=FCqC77ExYzrd8XUSPz2Bx2HKRn7z/2SzysNFL5wwpclcNWaiC3wuCC5Nqx5pZkPAwHCDtYSCR8+2R4DKITjyr6suZVdycLXZtl0ERz3hyoyjMkGsOGVUNFxObjp8n4DxUwMUYU2AIHf21zT9KVhCp6LVgoUSe07EgjCKsm8jLaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775125207; c=relaxed/simple;
	bh=C97VEa+NVtr1a+zTAOjF7qbw7z5ErHahekcY3LMMzjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Whszy8gRDkizfrDKuQJXTYvnf3xFT0mVmu3vryCSR8Rz+xu7qdoUWKDa95gsesAvcxLXLdCJWI3wBYbW0bTCZyS9xk6kAhUYZysJ2GBsvgKiQEVrG5X3y3FGNvYm1lNlnyXWe5H5HzHw/l6IrU84DDgUCAfl+xcm0k/opkBAUy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RxhVT7de; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kNRjvj9y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775125204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R9FNAq6JXxyYmLFJe3V/l1GPxm6IdqNxZH3xpVlwE3k=;
	b=RxhVT7deWSP0YaN0sQBWQyh5x0I6K54kiPOaKx23444CclWhOJDKDgGqDXQuLibWvI7O3W
	o560Yxz0l2xirwGWXu3rrX8i2GbvD6NIcy0V9jYd8oNexlt8ByXJYqMy4fp5PUEaS4Spzq
	gLkfHa53VAKBjjbw/TXeMjuG4PqF7Fk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-AQ45qLPQP36d-WL9qB-C1w-1; Thu, 02 Apr 2026 06:20:02 -0400
X-MC-Unique: AQ45qLPQP36d-WL9qB-C1w-1
X-Mimecast-MFC-AGG-ID: AQ45qLPQP36d-WL9qB-C1w_1775125202
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b250d3699aso16933235ad.2
        for <cgroups@vger.kernel.org>; Thu, 02 Apr 2026 03:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775125201; x=1775730001; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R9FNAq6JXxyYmLFJe3V/l1GPxm6IdqNxZH3xpVlwE3k=;
        b=kNRjvj9yiFQWTmwG/KTDnmcx/HtqjW+9dc4qKa4IlbqCLf+aiE9HAjybGN73a2yHhK
         XZGJK8vjmWwqrTR7i5eWXlTYyY2U9b1IcS6f0poGK7V6y4acTVgXuYLY/PWn21DfjgQe
         rWJQ6Cfk5cEzrQ9KlPtwVqAsmuCJG1RFZPe9807+6fWPcwC/e5J+vWX7XfimdhAIQSIS
         SVzKgcaMXPJKNMU1X8WQIOIAlpu5eSzju1J/7d0ze55pN+4c2QDsN9I8Dy4rUtBuYicz
         8hUkKEcapI6muqdHNI6E6zxRDZUJ6y0oVxmRjzbtifttYaCV8vhHXTSdQEeeKeciFFO2
         weGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775125201; x=1775730001;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R9FNAq6JXxyYmLFJe3V/l1GPxm6IdqNxZH3xpVlwE3k=;
        b=BfAyzM+OyBvuitIdsuU33ff4DWD+/KSgR5JokxfVj/iriruDxccF10CJ4v7zszGZlO
         NPQiwasFTcxKyqUabZ43xIIRGKd33mqrrwCdhZm0tijjeHBjE/52GJZ678xg5rQ1lbuO
         4erzpddTylHLs8CTE2Xw51xVoedizdHkXq9S7WapkYR/wjhVI3FU/0lxnD7TwRuLqOLa
         egHLRCtS1XTftXKLL9VUkcpK+oFZd2UoynmUjHbtcez1m2I1f67K0z4Ymxwbwc1FMq80
         uGamVtNy+M4RFQ1PZI4nIg3rjT1drBObhgMBOgWoVuZ8C9R6QGhj8d2i7CYPB6hbzjs5
         3GGg==
X-Forwarded-Encrypted: i=1; AJvYcCWaaTVD5cFly9wTWmImdb85Xok+bNhtguWtaoY2WFIpM84LN/cS3w5OFDA/emY3dL/gKWfeZNoK@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi1NYdT7884gzFVRGw+L4416g8M0lvrTYEvNE06DrE5fVb5fdx
	UkQizVnpewuktH34iCCQvjdPKJd9e99HTaseZerDMp7hgGGHVXvJQ6DC0Z1l0LCum9UdvkNLeqB
	CpSUXVdrd4PNk6EaM4dfaTGZZgTduWk16hqYRDHULzjWvEUfZh/sJwGp03Dk=
X-Gm-Gg: AeBDievo1+LtpkwxWLTV5HfQVxLlKeU8Nh3avUSKXdJEdwJErZJwY+p+Wlmt07Bx/HN
	B+kPvpKMhXxI0R4IaF1e9aNLzdtPvw57X0Tlqq2/vddrMZ3X0ck4i9jCSWHJd5W918Ha+5Scqpa
	3Qr3b5ueidFiE1DbYCz2my4/QrI1HulWIqsE7+bPXFxooy0+RvwRrn6lk1BemIHaYwMxSJuaLF4
	HX7fcUT1Bi8NMvypbTHeoxREqag+GjfoyTh4v2pOEuAJx+XqWcM9E3GSxXmIpa7AGalVKbZE0zg
	dFDCgchU0ttGud1GPS04yJoC51n8uSonftOxpxlwhuRgqTuim0WsQc5bwGI9+NyIupJHy9lXM3L
	SzQHmOljMs3No0pZKrw==
X-Received: by 2002:a17:903:248:b0:2b0:af2f:b26a with SMTP id d9443c01a7336-2b269ce75dfmr68411145ad.48.1775125200921;
        Thu, 02 Apr 2026 03:20:00 -0700 (PDT)
X-Received: by 2002:a17:903:248:b0:2b0:af2f:b26a with SMTP id d9443c01a7336-2b269ce75dfmr68410865ad.48.1775125200433;
        Thu, 02 Apr 2026 03:20:00 -0700 (PDT)
Received: from redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cada2sm22687075ad.71.2026.04.02.03.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 03:19:59 -0700 (PDT)
Date: Thu, 2 Apr 2026 18:19:56 +0800
From: Li Wang <liwang@redhat.com>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Waiman Long <longman@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	James Houghton <jthoughton@google.com>,
	Sebastian Chlad <sebastianchlad@gmail.com>,
	Guopeng Zhang <zhangguopeng@kylinos.cn>, Li Wang <liwan@redhat.com>
Subject: Re: [PATCH v2 1/7] memcg: Scale up vmstats flush threshold with
 int_sqrt(nr_cpus+2)
Message-ID: <ac5CzJ5S0kp71rrs@redhat.com>
References: <20260320204241.1613861-1-longman@redhat.com>
 <20260320204241.1613861-2-longman@redhat.com>
 <n6mhkjsxsami3qmczkdh57eep4lmcgbtyl7ox3ajzveke44yf6@m4bjevvsr47k>
 <ac42aIDVaGim5moO@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac42aIDVaGim5moO@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FREEMAIL_CC(0.00)[redhat.com,cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,vger.kernel.org,kvack.org,google.com,gmail.com,kylinos.cn];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15165-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liwang@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1AE38387AC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > with kernel functions:
> > 	var1 = 65536*nr_cpus / (45426 * ilog2(nr_cpus) + 65536)
> > 	var2 = DIV_ROUND_UP(65536*nr_cpus, 45426 * ilog2(nr_cpus) + 65536)
> > 	var3 = roundup_pow_of_two(var2)


Consider a 1024-CPU machine with a cpuset-constrained cgroup using only 2 CPUs.

Its unavoidable batching error is just 2MB, yet the global threshold imposes
256MB (harmonic-mean) or 32MB (sqrt) of additional error — 128x and 16x
overprovisioning respectively. Both overshoot, but sqrt stays bit closer to
the ideal.

-- 
Regards,
Li Wang


