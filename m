Return-Path: <cgroups+bounces-14990-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKzmMa3/wGmiPQQAu9opvQ
	(envelope-from <cgroups+bounces-14990-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 09:54:05 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4429C2EE812
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 09:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEDBE3010BBF
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 08:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA79382F1A;
	Mon, 23 Mar 2026 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ah06bRTP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mPCSK96q"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82A1378D64
	for <cgroups@vger.kernel.org>; Mon, 23 Mar 2026 08:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774256042; cv=none; b=g4JyThVmbkCIyq5X/xQoxxDJ3zo8mVJ3iEj/xdIq+K3w6+ojoNZ7xSShoQNlxh3e6I7euLSLDk4tUb5GUzMLpJkiJA1jim3F/mjo4KSXSJ6daOnO4CzoknmiebAQZnh1GhuEv4GWCJz8oxAJF/X5K85hVQ0YjR5BC/ap5HGUh0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774256042; c=relaxed/simple;
	bh=hThO1A1C8Xur/ZEGkwiOiLhsaE2lKnkvWmC7Eh4azQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLTJQkREgXxwuNA8MxVPCk4snmPq5dbwlXfQ3WL+L319ztH5cwyLMFP432qUhMds+tHh5bUBmuJMQUVyHlPF+XsbfrMXdOFoXiklVsi8SSe9qzi3+81rlvYz6gPgTYAN9SNw7kvOuhnINDr62fh1pjlu/eGKpBYSaoTzj5Hh/gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ah06bRTP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mPCSK96q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774256040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ogcl2ZAquuYNoAzauwvXFFTaynrHJWtFRV3iycnT4gM=;
	b=Ah06bRTPeq9tYMrEWY7cW9aXKxEN2qN1RkXo1cdEUDHZ1YqvEzvDA6MKdccqLiBNw8q5fv
	wAF+LPD50cXbSGgJPtY2lWrgWViHwF08NPvDj8N58fK+A9Hypnc3/798q6tgRQQ+ZdQ/n7
	LbjYPQOklIDhLbV34617J8r2RLTnhBc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-8DEgXJfLPyiZSRFXsjEn-Q-1; Mon, 23 Mar 2026 04:53:58 -0400
X-MC-Unique: 8DEgXJfLPyiZSRFXsjEn-Q-1
X-Mimecast-MFC-AGG-ID: 8DEgXJfLPyiZSRFXsjEn-Q_1774256037
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-358f058973fso5707972a91.1
        for <cgroups@vger.kernel.org>; Mon, 23 Mar 2026 01:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774256037; x=1774860837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ogcl2ZAquuYNoAzauwvXFFTaynrHJWtFRV3iycnT4gM=;
        b=mPCSK96qYFs307uVXfmXc2YWal8UYRqhCsgm780ZuH+wG749Ke6GcOs+vG4NwMXzyn
         j8/s22LJqxVdN9xrPIrwoCjpmOeZvHma6n4xk8Eha20A1mx4Zxl5WYN64tCO6Julgdfr
         VwsXRcBwN0gmjNNeknBgMwFzjgLYnSBSxxbamExjTCXvcCJEBI17snT7HsPYWjSQp9dw
         h84pIPYi6rd0fRhmYeUlaRjyoO0LevwyOXUU/4B6AOrXmT28Orj2vWv13TfdlbqurV/P
         MFYovqwBJSlhFzPppUiwySvxE9CTZgQ3ooUMIeBJ1KnljisHjWLHzLe+Bq+YMAO3OIOA
         RQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774256037; x=1774860837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ogcl2ZAquuYNoAzauwvXFFTaynrHJWtFRV3iycnT4gM=;
        b=Vzu5KqRy+uoib0LoE7ApzokE0CqGWg6jJsX6NUPxwSGPd237jxNt0qlRICBnnvfPgc
         k3YHh1tqiv1my3q15a1CpItxAqXn8n0R77TMElMYfrFPcAK+WEWWYdWOP97KJ5m5oWL8
         v5q2222bK4B7bER9TSYLqhsHSMMaoK29ifDamclD7Qilm3E+no1Yw7YcxEJKu1ifZV25
         n79nYsJl/mfruwVqiWFd1Xi5clrlZavFAhHXow0Zp6AtAhzCQFzLSOyT724DrkiCB/DU
         rgyJ/tbyF227TB1H9yP5ub02oo+8w0jQejeFx6LisaKDt/AXvcvUQIHyCU3SNgVXE6Ry
         GWmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiT2UdOVHBZRWb/iIHkyPhMTQKPNv3zZJlVSaVgDG7SaG3ixQRwoDtTURmOQ/1g6ob5kq0WE2j@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2RdLpPmMzM37x+P9k2XWbxbb3GLmgQ2bQfduoC/uyKecLDqS1
	2CU/qnuB/sHQyyNvZ3BOblvq/Do9JMMClCz0U0lnVtgvQ1bBcyuorVcgFt81ovKbsRygquRmbD5
	JAE5M09UIdr9xgAFrn93noZ225fO4OUdaLKMMea1LAKiCK2xrQdYMUP5IJ4k=
X-Gm-Gg: ATEYQzz8dI4IaT084Va+57dXbQKmfM0hMzI4EbKSTzTFZL6j7yVuGBA03bdDl0uy9cJ
	N41MH3awaJofNRYJugs1r38XsZa+OESgj7nvsTao8Nu3cYhsJldJXmD+s5EVB6ynNEIVnyavXfy
	ZzOV87C5zVmJoZLMOprJIiNfVPP0dtfLXCyvtd4a9b4CCoponvlzxPnthSk5pv3MAGrRd6MOUU6
	bGv1F4DPYgIEusSHlpyRRlWIVWLoidJkaFYVqlRI89SfHbx2r6+ZNHnZg2KLlcvd0ILBhQ+AWmf
	X5Fis/MvbG617H4T5x4ZtoTwcEcNwHFIEchVMyNfQNjTjVe8YxMvk5amAtttq4sv9iBqRWMO3Il
	oRMjhsAbCiB1KMVg9Cg==
X-Received: by 2002:a17:90b:28c8:b0:340:4abf:391d with SMTP id 98e67ed59e1d1-35bd2cb1ea5mr8848395a91.16.1774256037069;
        Mon, 23 Mar 2026 01:53:57 -0700 (PDT)
X-Received: by 2002:a17:90b:28c8:b0:340:4abf:391d with SMTP id 98e67ed59e1d1-35bd2cb1ea5mr8848368a91.16.1774256036672;
        Mon, 23 Mar 2026 01:53:56 -0700 (PDT)
Received: from redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a7ff529sm7219812a12.2.2026.03.23.01.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 01:53:56 -0700 (PDT)
Date: Mon, 23 Mar 2026 16:53:53 +0800
From: Li Wang <liwang@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	James Houghton <jthoughton@google.com>,
	Sebastian Chlad <sebastianchlad@gmail.com>,
	Guopeng Zhang <zhangguopeng@kylinos.cn>, Li Wang <liwan@redhat.com>
Subject: Re: [PATCH v2 6/7] selftests: memcg: Don't call reclaim_until() if
 already in target
Message-ID: <acD_oR9CmOkQFBZL@redhat.com>
References: <20260320204241.1613861-1-longman@redhat.com>
 <20260320204241.1613861-7-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320204241.1613861-7-longman@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,suse.com,vger.kernel.org,kvack.org,google.com,gmail.com,kylinos.cn,redhat.com];
	TAGGED_FROM(0.00)[bounces-14990-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liwang@redhat.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4429C2EE812
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 04:42:40PM -0400, Waiman Long wrote:
> Near the end of test_memcg_protection(), reclaim_until() is called
> to reduce memory.current of children[0] to 10M. It was found that
> with larger page size (e.g. 64k) the various memory cgroups in
> test_memcg_protection() would deviate further from the expected values
> especially for the test_memcg_low test. As a result, children[0] might
> have reached the target already without reclamation. The will cause the
> reclaim_until() function to report failure as no reclamation is needed.
> 
> Avoid this unexpected failure by skipping the reclaim_until() call if
> memory.current of children[0] has already reached the target size for
> kernel with non-4k page size.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang


