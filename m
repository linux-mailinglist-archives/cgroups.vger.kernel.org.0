Return-Path: <cgroups+bounces-15171-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLl6IaP1z2lT2AYAu9opvQ
	(envelope-from <cgroups+bounces-15171-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 03 Apr 2026 19:15:15 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0BB396E66
	for <lists+cgroups@lfdr.de>; Fri, 03 Apr 2026 19:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AB24E3007A6F
	for <lists+cgroups@lfdr.de>; Fri,  3 Apr 2026 17:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6913D34A5;
	Fri,  3 Apr 2026 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="lakGOcj9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476423D330B
	for <cgroups@vger.kernel.org>; Fri,  3 Apr 2026 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775236509; cv=none; b=ELZPxfjEAcQs3m3ZdjinaU4T4iJjmXOwtRyarQjo90W4+QEsS5bVkKo+VhjHFhp+RE8M3vexun/6ZmT46JTsjqTPimnc0AzCmwDehV66OtRxZQQEVD4hnUCzkU5UoZSAvc2XqGA/iC47QhUSHIk8Es44LRMnc1gdjFl1SjzfQDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775236509; c=relaxed/simple;
	bh=TEN7Czb3HE1oFzWweDLJ2JH8bwaI3J3Vnf/K2FyeNcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNAdVDANAqxPoarOMvws5eB5QUBI3/ksWpQw3KMeNr0ILFJE4Z6k9mm6vv8yV1DJvV6b2r43TLUN8ls1D2R7S0PItrEVOhXh7sfyQGNTsHAlLzKpSfNMzFqI8J+E8W/340g6Tab/Z3j30iQlLhY5trosKNHWCcb8eHrp8P2diWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=lakGOcj9; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50904a8f421so21955541cf.2
        for <cgroups@vger.kernel.org>; Fri, 03 Apr 2026 10:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1775236506; x=1775841306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NIb1V/U3iyEpQy5G2ZO1niSW/i2jfqib/HV9z8tr9R4=;
        b=lakGOcj9zaV9hdFnY4kgkyE3cwBw5XGVaU9IkM5FqM+Xx9Hkh/Myx7FifO3OK1O8pi
         k5ameBSPuIR0arz7vvvhwuEGcAfZ3EZTK/x+npIRKOEOV6X7Fn/CqsKBBJOCPnRg5Bju
         SAQCviy10+lUMUeciX02NnJOOMNanA8XqbLtagnr2uUsFo8qNYlLMqORdZZl4iCvzGai
         5A1fwQ4PEA+RSv+9I8fzUsxtQ6VNNsy3TJjxooHLKA/wkRUgXgebwHPvURCLMvUTl9uT
         jx0b+yhtnBt+T0MMMSqlZSzj7wS5n3777R/Fg1EHUlrvQAetsvi1xYjG1yMCAl99D6so
         F1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775236506; x=1775841306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIb1V/U3iyEpQy5G2ZO1niSW/i2jfqib/HV9z8tr9R4=;
        b=hst/p+z5Npr1A62UcMGlC2Vrz2KJGQ9UkYKQrQkq+kE6QSJNn+ZqpGDYrE0MvGPWVb
         bgX0VkQmMqieziVaXaa5q3Z9R56hTvo4cPgOSDsu3LHVjGvot4+ZVqi6GJPzgEUQLPTJ
         8KcI60nbkkNpHdqQvgoGdm6YDvHN+Hj207FJIVAUXxZvC8Pzs2lXXO5TjKKAOLfbqnkW
         0MPZZpP8hVtvqyxcFfqVcAd3R3EfhAL+2yzgbXLR4JOsnWNxYboLkR8ZU7grwQ/pV/b+
         Hao6ktakK7Px7Vb4LaEx0xfJorORLA0FRTQwt5i841SjzfTzIZLgAemYHXrMbMA0r1EV
         GkPw==
X-Forwarded-Encrypted: i=1; AJvYcCVBfGKWnTVCRChm6BLpBH0VTDO1tJ/8o36SFLjTSUwjZxlQ3OFq9l3jbfq9tDsfVuRrnxQvJOj5@vger.kernel.org
X-Gm-Message-State: AOJu0Yya4qiNIZ5+4eRTgjGSqhuvzauYZuCKvlExOVsWFIeYhUJtqHZH
	htqjPsZ4hyAF5/2kotIp4gzMUEKVBQ1afXbfAd78or3LyMUkfSXZcOsDrXMOw1bZnyE=
X-Gm-Gg: ATEYQzw33p7/q5LjR7dzhFay75wQXY6geR5y4e3WjeEa7ABfcz36JtQfPy1Hm4G5ZBA
	AdKw8L/tRL8dJlzkmZYeMpQ3Mz/mVBthO4hZsmYt93FAX/W4lVzl1HTRuEZyfsPag+dsmmsmYIb
	VEWbtOEdcAtzcTISuBYPvNcezF8PYzVDBcWwDSSJleP1+mJZtar3REh6FgL9GZMbGp8RykEQF4O
	wQjP8u3pFg9agukKmKQlEZpFerk5/CdLmLskrEvJ/HizKVIccgMJqcVn6zgP066PjIJdzJGcJS7
	+5JRT4BbKxxvBhalamjzGMOHleDyVcgs1rP+F382+sTs+i3zmsUFM310otkJWEEmAw1weXrH7X5
	QKD4VMoiuq97A5lMhK1PrZ5wR1SrTngNfXzsjJYY8tCTTiZxB2PQ0sMOKBQOqWL94HOMWH1dgP/
	BZQPwXmJ/2kYnaSlImMJtMLQ==
X-Received: by 2002:ac8:57d2:0:b0:50b:b32d:b55c with SMTP id d75a77b69052e-50d6209bd29mr57954271cf.0.1775236505840;
        Fri, 03 Apr 2026 10:15:05 -0700 (PDT)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4b93dd10sm49032401cf.7.2026.04.03.10.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 10:15:04 -0700 (PDT)
Date: Fri, 3 Apr 2026 13:15:03 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Eric Chanudet <echanude@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maarten Lankhorst <dev@lankhorst.se>,
	Maxime Ripard <mripard@kernel.org>,
	Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	"T.J. Mercier" <tjmercier@google.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Maxime Ripard <mripard@redhat.com>,
	Albert Esteve <aesteve@redhat.com>, Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH RFC 1/2] mm/memcontrol: add page-level charge/uncharge
 functions
Message-ID: <ac_1l4Fyrq1AhY8D@cmpxchg.org>
References: <20260403-cgroup-dmem-memcg-double-charge-v1-0-c371d155de2a@redhat.com>
 <20260403-cgroup-dmem-memcg-double-charge-v1-1-c371d155de2a@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-cgroup-dmem-memcg-double-charge-v1-1-c371d155de2a@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,linux-foundation.org,lankhorst.se,gmx.de,suse.com,vger.kernel.org,kvack.org,lists.freedesktop.org,google.com,amd.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-15171-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:dkim,cmpxchg.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D0BB396E66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 10:08:35AM -0400, Eric Chanudet wrote:
> Expose functions to charge/uncharge memcg with a number of pages instead
> of a folio.
> 
> Signed-off-by: Eric Chanudet <echanude@redhat.com>

No naked number accounting, please. The reason existing charge paths
require you to pass an object is because there are other memory
attributes we need to track (such as NUMA node location).

