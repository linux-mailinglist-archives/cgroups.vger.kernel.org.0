Return-Path: <cgroups+bounces-17188-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FZ8TOlKyOmqoEAgAu9opvQ
	(envelope-from <cgroups+bounces-17188-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 18:20:34 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD746B8ADA
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 18:20:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gourry.net header.s=google header.b=CTnObVeS;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17188-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17188-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F34D3072427
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 16:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2397030D3EB;
	Tue, 23 Jun 2026 16:18:09 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CCE2E717B
	for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 16:18:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782231488; cv=none; b=GLRAf+9S+gWRSXlU3E9E977ifFjjK9N+89urljJUbFFYrCmYpTl9n6Su1L0lY7waytGn/cuNWSs+vFP5S4Z2vMpv9RvIIHSzifE+GrjF+LTcyUq0BtZXOj0Kp7d5CBAKEtRRBlDeWk98fGYSoaIk8ZAE92k7hBNje648wfngkgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782231488; c=relaxed/simple;
	bh=yQ/2V8AdGt/OsdP6nNGTRalitVQPjN0hlG1iBcMXEfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrnjKe28TWWTaF5ajJ2um++g0G0JV1Z4gYSx9TrvswodOjDgwT721HiRZnOdVUCZ0giPuC96FKqzh6fO5DgPvrhEbnCwxsdrYslQZmKwUo+wOBrQNTvmIy2dRo3We1aHCesthVTtzEQTCfPKrvnJsfSojiwG+QXedpfBFYMk5no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=CTnObVeS; arc=none smtp.client-ip=209.85.160.182
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-519f758bca6so29634801cf.0
        for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 09:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782231487; x=1782836287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ensxYQeCjvjjMLApB8HU0cGYke7NMa+ar1iLrLEf4jE=;
        b=CTnObVeSZ1QOHzqXfMG+z/CdMgaEMBEdAgzVXG2T1mg2G8pjB2lq+xZc/Lpfigm5OV
         HbYqCq5PPyLyog4VaK4LrWadFaQun8JSgnpxvOnH7kc5GEhi82FucTiwGlhwMeESnqel
         PFFIYiwJTgXbyWD98sJBnjlKYMJ0eaNLsMr1D/1VZC1xhwZedzsoqoBZBx5Nz1FXpMHy
         Nof7uYR5ureKu0j7r6lDhJlWGn0J/kqra5PuzJfCBhYxK4AUPcNf+YXx9CN6KTETdyaY
         U6g3H4+S3hZlEKNLtXIBqI3y1c0WkNi4x2M7DcSFNcCE6xwCQX80AQXeYaqGGsk+x4j9
         J6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782231487; x=1782836287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ensxYQeCjvjjMLApB8HU0cGYke7NMa+ar1iLrLEf4jE=;
        b=mTWSyczI2REawWrcQ4Uvql646O7Nk6Q/Rw4vO9ehJzel7xR7iOM52T9Q4HiXNMtn5c
         75YCk4W2+3eMWspbQYoxSMe8zUeVLSwA4KcbT0cXrKKLVp34fBOchQBAwok5lgfH4IXI
         H/0P3mH9g/N931r0wY0CIfO2vzS1KUxvRxDeduYb+VUmdo+kn+0SNM2zKNXCRHkkSTBy
         qUvsigyeookS00EztWutobHV7CseRPb2wAsg1TXv/Chpbr29cfZruXGuWK5QgvpxgoNU
         xtNl68eNMOfVX3RXyzI2gsc5o7VFCvkIbotJObmSQTVVACAuKB8gW29BAriOo/uVcFHl
         SFJw==
X-Forwarded-Encrypted: i=1; AFNElJ8PJ+/8h7a3RvaYuL5EVFTA3wgtglBVKkVo+r2X/JWnZ0ulIRtdE6khOy6I1oxt87LaZlQofVlh@vger.kernel.org
X-Gm-Message-State: AOJu0YwcNUp4lJZRMxFrL2zQwE/SegqUtbgBypRM2G2Pc/bHcr9P61NE
	1rJyqQSLSv6v4Pr950YKQTB6ln9MAcLaNvuwptuYeNH7MJwRNdIIJtLIck9Rw5hjqvA=
X-Gm-Gg: AfdE7ckKJkYK/UnTN7tKQaLtrKsvQ9SOwt111AryM2rvS+oGNP1KEsekQw/J/lG6VuH
	EhsAmlXdoOkNKjUfNTZ33bPhg41NcztUTEZhYr9wgN+KJSGt/dhByYosFOdRn0lZIFP5OKIz8xL
	odlDhT6ZkVmLzBNam9ZjyCAycG76RfK/IH0sFT6Vm0CFWgiEPFSz33zukN6PY3mVH2gKpDfqKWm
	zWLqssFEMaJSOLLE84QeigdqfpCKj9mv3d9Dgeg2TCclI35SbQXhQ19LhgHHeJmt2qxMuUSIBo7
	ORit3aVtLjZX0+hB+5Eqkv/Ys7Xnq5uFEZlFQ1BcV+QwagEGRm7LWIIo0iMbicmFkjYarwnhXsG
	7QDKylfSfzOTGa7ezNUK+O6EF7+Vyjpe6Nlhhj3Z8XSa1aGa1lCGrSlALATpj8HXxYuA9f9kxLq
	cLKvx916kNvG5dYQ5rfDAe1DBbhB1fiR+BMVBLI6/aGy10LUWj3G2KeRTIuFGJzO+BPhmP
X-Received: by 2002:a05:620a:44c1:b0:922:68e8:d945 with SMTP id af79cd13be357-92268e8e0camr2119154085a.16.1782231486751;
        Tue, 23 Jun 2026 09:18:06 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926005a18bfsm308798185a.37.2026.06.23.09.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 09:18:06 -0700 (PDT)
Date: Tue, 23 Jun 2026 12:18:02 -0400
From: Gregory Price <gourry@gourry.net>
To: Waiman Long <longman@redhat.com>
Cc: Ridong Chen <ridong.chen@linux.dev>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Li Zefan <lizefan@huawei.com>,
	Farhad Alemi <farhad.alemi@berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, Aaron Tomlin <atomlin@atomlin.com>,
	Guopeng Zhang <guopeng.zhang@linux.dev>,
	David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH v7 4/9] cgroup/cpuset: Add a cpuset_reserve_dl_bw() helper
Message-ID: <ajqxurL5rRu27po7@gourry-fedora-PF4VCD3F>
References: <20260621032816.1806773-1-longman@redhat.com>
 <20260621032816.1806773-5-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621032816.1806773-5-longman@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:longman@redhat.com,m:ridong.chen@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:lizefan@huawei.com,m:farhad.alemi@berkeley.edu,m:akpm@linux-foundation.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,m:david@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-17188-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gourry.net:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gourry-fedora-PF4VCD3F:mid,gourry.net:dkim,gourry.net:email,gourry.net:from_mime,vger.kernel.org:from_smtp,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5DD746B8ADA

On Sat, Jun 20, 2026 at 11:28:11PM -0400, Waiman Long wrote:
> Extract the DL bandwidth allocation code in cpuset_attach() to a new
> cpuset_reserve_dl_bw() helper to simplify code.
> 
> No functional change is expected.
> 
> Reviewed-by: Ridong Chen <ridong.chen@linux.dev>
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Gregory Price <gourry@gourry.net>


