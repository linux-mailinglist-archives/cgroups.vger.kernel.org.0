Return-Path: <cgroups+bounces-17623-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UP4VCpeqT2qRmQIAu9opvQ
	(envelope-from <cgroups+bounces-17623-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 16:05:11 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BAF731F48
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 16:05:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=PQLGoyX+;
	dkim=pass header.d=redhat.com header.s=google header.b=LOntyHXA;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17623-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17623-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15272311BFF4
	for <lists+cgroups@lfdr.de>; Thu,  9 Jul 2026 13:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FF331F9AA;
	Thu,  9 Jul 2026 13:45:10 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA653368A7
	for <cgroups@vger.kernel.org>; Thu,  9 Jul 2026 13:45:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604710; cv=none; b=NITnhBGPuOdN7KLApgdRKMvumO03qhTxgDkoU+QeW+BOPXXUiE9+huOooFpiN+hwoSPWo41bBFbuYKJQacwTgKa2pWLFD1Ojl1R8Me/NzybZYQZc6sFtdmdXMZO4GXZfsXNcFgLRYNZsgW8UpNBU+0m/5M0IkRx9o5TolX1D6iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604710; c=relaxed/simple;
	bh=hV1txD3s0gTLfPiS3b2/9sZVWfKgrmrE3xMhHxL2XQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWY4DD+jxYfmeSi5YS5jG23VliPrEX9RMrWVeaJRZbKjXK1SJixAj2XAxr2BovNIH/hLa3/6vnVppYx0gtA+dpZmZTXVH62vIWkoWnP2IVl0L+ZOnO3PsxM1UVcfvj5PDqbROX9VfVIQ2QEUaAygaBmgfGmIL9X9Nh7/qH9mkNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PQLGoyX+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LOntyHXA; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783604707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0B2CCHmIqiYi2OjZQM05i6RdlCsyGmxI7RbfTKwg3sQ=;
	b=PQLGoyX+0pnsynX2L4PyEMCpKdGA3ajQw8Blf2UGg0rhosq2VDqNDerlGl3Uocpt2/RVVm
	QKIJs6pszfuzQhr9/jZWqu9rgweLMaSYKveQGbTNUCB4MEB6V/k1F/6vCMyfJ0onKpe9i7
	Hicu0FR7Mjs5fCaEDeCYgXERLU6302k=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-rdlip_AEOGOzUtMuCwcaww-1; Thu, 09 Jul 2026 09:45:06 -0400
X-MC-Unique: rdlip_AEOGOzUtMuCwcaww-1
X-Mimecast-MFC-AGG-ID: rdlip_AEOGOzUtMuCwcaww_1783604705
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92ec3146553so159828385a.1
        for <cgroups@vger.kernel.org>; Thu, 09 Jul 2026 06:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783604705; x=1784209505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0B2CCHmIqiYi2OjZQM05i6RdlCsyGmxI7RbfTKwg3sQ=;
        b=LOntyHXAiZrtud2uZP7sWN49TGh+ZRBTc5d0v8HDoTKwKJBzwF9Ma4RMASqFVza5R/
         HNp8ANMbNbXRcIre0TJzUdMGPM2m2LVnsokqBx1IiWTECtywQD6JDd05TSip63Ddrc3N
         PSpBxbyZdkaJN1GGRo5q/JBp1VcMrPJvvLTfqffqtkSoc9kjnM7N6KcwIp3UTkGFwlyi
         AwqFsCgPW+UaW+JWnCg+bqPnWLExHonHb8CrA7K6MjeMv1CMd6AVNprnhwaEo20ixN5z
         7iprXONBeF6+iAxwFXeiBLuf+aBG0OT7vj582dPd0N8TJbGfVXRamzGYgIYeisOfzMnt
         3Ldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783604705; x=1784209505;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0B2CCHmIqiYi2OjZQM05i6RdlCsyGmxI7RbfTKwg3sQ=;
        b=BV/WG8P73Q2XO1S0ibwcFrnjTuXrjpsmDo5p6SWpW/HToyGucxGAWR8KkHl/jYzjAg
         UkR7msECoBpL2xXD6vbNTzrAntCiwbTk18/czRPoUDtJYRYNB1MHGZUAj+85DpPBfDWg
         dgXhfdTpfh/Cjo0y2YSmdavn1rUFyZ7Ml5e30umQyjzSgUrusy11rW0hW4FQoefzO+lq
         p60wPtTHMooa5TfDLLWgCpYkPOOyqYYRzH0jB9aiYw9WBNAT0FNJXPeclKlaXjFCGnYx
         IsMJZ2WOWmcx9K64jL0QN3lHP2Zr6eWK70zgPV7l0pkZi08P6oltpw/Lrg2AyozLCTMw
         W5NQ==
X-Forwarded-Encrypted: i=1; AHgh+RqFBBYTIdFfKbex7gi6L73SzxWMLcijWaBOWoipGxcdtXtv8j3sKIoT4GBwh1XE5igbbhi7Idp9@vger.kernel.org
X-Gm-Message-State: AOJu0YwubXuDVIJCAJa9Vad4oz5gjH4Syb1nZptg9rQ6JElrPBzDo5s6
	RZ6+sEHEgux+96VTLsvstmBEykh13AqRWaH7V94hBwcepWl9LxFvQGWo4LamIUbP9p3eamfQJ4w
	/n/JTUo9HQE8gzcFmFWH0/faPVU2+59Vmh6n8DhdomrveLMbMlmoxODKZjcY=
X-Gm-Gg: AfdE7cn09jrA24e9hg7V2dlLUh2Nbd1QQqeQL3JPU4JGAr6EwcIywBPcJCrvwCx/r0k
	BAeoGMCEyZDslKMqQYzfqoLMJcgrDoB1lzhFTuYGNQYaGAy0tarE36P6QWOQB7lU8sDdMfIbZF6
	OAmLdJ4j+NQsmboWMDvED59ClC9+13PsnR4W9PVFGmRNqq/+EcCtCQphEKSXQttpDcFPH9M73CE
	yCSNlf2C/SehSbxSp/gknQMdGYFRoNqxaRKLA25zJ3NEs9YXRKsbREgjksDXtSBG/8qidOCqLua
	3fgmuA1GyMp5iDh+z4pIb+y2Ni4ygv7w/l+0p9QN8ErIZBn66xemlWcPLhcn17x1jGjBLDG09cd
	WgBGXpSkI56PATA6jjaoAL9ntbIm9AwO2U4opgznc5rnCiaAO0sJ2UUg=
X-Received: by 2002:a05:620a:4624:b0:92e:48a2:533a with SMTP id af79cd13be357-92ecf6aa74cmr764350685a.47.1783604704828;
        Thu, 09 Jul 2026 06:45:04 -0700 (PDT)
X-Received: by 2002:a05:620a:4624:b0:92e:48a2:533a with SMTP id af79cd13be357-92ecf6aa74cmr764344385a.47.1783604704231;
        Thu, 09 Jul 2026 06:45:04 -0700 (PDT)
Received: from localhost (pool-100-17-17-231.bstnma.fios.verizon.net. [100.17.17.231])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90ccdf8dsm1665479785a.37.2026.07.09.06.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 06:45:03 -0700 (PDT)
Date: Thu, 9 Jul 2026 09:45:02 -0400
From: Eric Chanudet <echanude@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 3/4] selftests: cgroup: Add vmtest-dmem runner script
Message-ID: <ak-gNsQ8vi7yDJsm@x1nano>
References: <20260706-kunit_cgroups-v5-0-6c42c8753468@redhat.com>
 <20260706-kunit_cgroups-v5-3-6c42c8753468@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706-kunit_cgroups-v5-3-6c42c8753468@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17623-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aesteve@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[echanude@redhat.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[echanude@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 85BAF731F48

On Mon, Jul 06, 2026 at 02:06:42PM +0200, Albert Esteve wrote:
> Currently, test_dmem relies on the dmem_selftest helper module
> and a VM setup that may not have the helper preinstalled.
> This makes automated coverage of dmem charge paths harder in
> virtme-based runs.
> 
> Add tools/testing/selftests/cgroup/vmtest-dmem.sh to provide a
> repeatable VM workflow for dmem tests. The script uses vng --exec
> to run the test directly inside a virtme-ng guest with minimal
> setup.
> 
> The script boots a virtme-ng guest, validates dmem controller
> availability, ensures the dmem helper path is present, and runs
> tools/testing/selftests/cgroup/test_dmem. If the helper is not
> available as a loaded module, it attempts module build/load for
> the running guest kernel before executing the test binary.
> 
> The runner also supports interactive shell mode (-s) and reuses
> the verbosity and KTAP exit-code conventions used by other vmtest
> scripts, so it integrates with existing kselftest workflows.
> 
> vmtest-dmem.sh is placed in TEST_FILES rather than TEST_PROGS so
> it is installed alongside the test suite but not invoked
> automatically by run_kselftest.sh. It requires a VM-capable host
> and is intended to be run manually.
> 
> Signed-off-by: Albert Esteve <aesteve@redhat.com>

Reviewed-by: Eric Chanudet <echanude@redhat.com>

-- 
Eric Chanudet


