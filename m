Return-Path: <cgroups+bounces-15181-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKaxAnYV1Wm30AcAu9opvQ
	(envelope-from <cgroups+bounces-15181-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 07 Apr 2026 16:32:22 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9A03B0115
	for <lists+cgroups@lfdr.de>; Tue, 07 Apr 2026 16:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F47A3025492
	for <lists+cgroups@lfdr.de>; Tue,  7 Apr 2026 14:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0D126FA6F;
	Tue,  7 Apr 2026 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hPIsFLyr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rhlb/9DA"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAA3219301
	for <cgroups@vger.kernel.org>; Tue,  7 Apr 2026 14:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775572320; cv=none; b=CC8KmrVOGbvRm4qL4bMIiKTpmSQKUVobL8e48XJPwVfsBQ8/jSDPAPqqCCqvatvj7kg8stM6rFznzTTAeILA8EaPPrfwl4ve5tq7bP7KNaM1wtdiHG2MuUUdC/Bir54wg0tXNxJm/Q+9squqeTguP3AfymmwsW70rJ6m64HRqhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775572320; c=relaxed/simple;
	bh=r4YzEw21ujo/Ztcki66z43LaC0/+Qo+3hREeBX4z/TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLxmf3sAqH5ScPwqsFaXSSc/kTCpaK1qDAa0caCyGLlGrwTnmeo9Y8aOPmgEDYJwHRF3aNsYbHuW1MPuxRUggU9i8wnPiG3NCBSYHAYubclWwwdraRjuTHetyc/MjbfYTOPQAZ89E8Dt+pqvCorzJFu7xhDqpJ86DAu0jCogOr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hPIsFLyr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rhlb/9DA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775572318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8UDiNGg7oHctRKWHlUV1gXCd4Od4na5ntrKyJgT/gtE=;
	b=hPIsFLyr3W4VA+ne/yME1BuVFdvRCHH7xsvKEddcnwI9bJXKoKw+eGKfBwgxCP9P5RHUqm
	yuPicpsJNRdCJPgwhh/JZUa8WXmVa6nyw+AwIk59Ms4zby3KfYPFMVj+eVKrMeLyffs0aF
	fD9Mu+9jIyG34A1VxBl3pZeAN1Vtv4M=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-KE0EXtlGNiuKTr81QYfqrw-1; Tue, 07 Apr 2026 10:31:56 -0400
X-MC-Unique: KE0EXtlGNiuKTr81QYfqrw-1
X-Mimecast-MFC-AGG-ID: KE0EXtlGNiuKTr81QYfqrw_1775572316
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-953c8c95134so9650076241.0
        for <cgroups@vger.kernel.org>; Tue, 07 Apr 2026 07:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775572316; x=1776177116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8UDiNGg7oHctRKWHlUV1gXCd4Od4na5ntrKyJgT/gtE=;
        b=Rhlb/9DAbS0x3srgr2Wj6gRMMbtOMAtQ9YmWKbZBo47hFkb3BRWlAjr+zfLfGRO/FF
         cPkGwzdiRRmhc9MQy6z4gpbQPdQYsbpBKxlLqExr17Vpzo2DcQx/FbPkRs2m7zLtJuzw
         k0e2+94d6pugIAONBLhsCUqJbxavXC/Sns4IsigEvsXKbXE7R1CDvt0emfYXbdDcHQkp
         7Omoz2z1WBcwAAN9M8QZXe2SmnffiD2HjlR4IFemldmUl8rp1XiimnFPQd0hpbxeUff6
         SHs3Wd4hmR3bfpPeFmcpFvPFvU1R0hMYPqZuRtH193ML20qKCebcWZEmkWjsX0luBmE1
         e7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775572316; x=1776177116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UDiNGg7oHctRKWHlUV1gXCd4Od4na5ntrKyJgT/gtE=;
        b=BxKTwi5ZM7XjtAsThU4dfht1AWZPRNDPrlj7nzihxiw1FK8OzV903zK02rpF5ecpMZ
         jKVb+GMXGV3kvKgtM5m+L1dRb7zogBwuE52IFXNFInlkVJoPX+KsgcB8sw5c5DpKpGso
         +CpL/qHe31jxXcbNc+JOsS0h9JRRKIYrBS48aeAjGxiactW9Wvx+k3+z1sq/ZNCm0m4s
         mZVC4OPsynZkLZe2L+/UluZbuyzzj1YyJzo+iEDg9f4hhUKy6jMAFm9mciLQWBVvO8gG
         6lcmSy/8+BTtTL87MAhsdEfw/vtt0ymzwB2uWvEcvPhI2rxdnmaB0YsxlpP5mbj22ykT
         JtXw==
X-Forwarded-Encrypted: i=1; AJvYcCU3nWlGty5XzrQIlC4WLEK9pnQlGr7ULywd2ayI1DpOAxaMlZNS33yQ+Kv7INIYslkTFBJ2nj8b@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/vcnyXwpdCCUJPMqx3wXBT7v5sKg48uAtfwn/PgunNpHTocXR
	tFHtu0p82JVPqSee6nNkzBz99ogB0KADObsGfEHPgNhy3GlSPZ6DCy4j11VsDVPw2J8//s/gsot
	ZWEvEKnFRttEofCMMCT+baNqUFElchsUYmEdF4ykgJLkc56YAh+kXXeJZvNg=
X-Gm-Gg: AeBDieuupqkkzL6nBJgPktUXVxFFxLvRGo4vn8LX9oNZb8n0Yo/7WiGn1MHzoHRDxev
	VIBK+SGZGsKPQFC+ZkE7y8YCowiWs7ycLgEtOXJzUuZWcos+8ux8PSXKFfS+b+yxGLYhlE09IKs
	pG2KTcmyrpwZ7VKJ4tfBlD4sKGhDud7MWbuDSzFJr1QRA3mSwVPXM8/39Kk++0/EI1q7fwYa5Rf
	WxaZu3UadZ9AKBQ98vbyeakHoIvWkPoAu5Nb8Aw5AZvy3V10wyFY7D1mawzwRVaH6U4f/Kw6+f0
	seOz/bDpupJOwecCQl0lWyYnhCjM1V6tVoNm7UUqU4hWWUj+e9mjKFI1TMftPTXo8p8xBCu2hWy
	R72J5iemYyk0xTzpTSJGupnqMqFqLro5Z2WEZDY0+tMYvr3xDhuk8c0TGlveSkpw=
X-Received: by 2002:a05:6102:1487:b0:602:b037:4de8 with SMTP id ada2fe7eead31-605a4cc6f09mr6384686137.4.1775572315641;
        Tue, 07 Apr 2026 07:31:55 -0700 (PDT)
X-Received: by 2002:a05:6102:1487:b0:602:b037:4de8 with SMTP id ada2fe7eead31-605a4cc6f09mr6384602137.4.1775572314700;
        Tue, 07 Apr 2026 07:31:54 -0700 (PDT)
Received: from localhost (pool-100-17-19-56.bstnma.fios.verizon.net. [100.17.19.56])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d3edb58da6sm1104864185a.8.2026.04.07.07.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 07:31:53 -0700 (PDT)
Date: Tue, 7 Apr 2026 10:31:52 -0400
From: Eric Chanudet <echanude@redhat.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
	Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	"T.J. Mercier" <tjmercier@google.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Maxime Ripard <mripard@redhat.com>, Albert Esteve <aesteve@redhat.com>, 
	Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH RFC 1/2] mm/memcontrol: add page-level charge/uncharge
 functions
Message-ID: <adPzsvwzkTCOh5RJ@x1nano>
References: <20260403-cgroup-dmem-memcg-double-charge-v1-0-c371d155de2a@redhat.com>
 <20260403-cgroup-dmem-memcg-double-charge-v1-1-c371d155de2a@redhat.com>
 <ac_1l4Fyrq1AhY8D@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac_1l4Fyrq1AhY8D@cmpxchg.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15181-lists,cgroups=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,linux-foundation.org,lankhorst.se,gmx.de,suse.com,vger.kernel.org,kvack.org,lists.freedesktop.org,google.com,amd.com,redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[echanude@redhat.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6A9A03B0115
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 01:15:03PM -0400, Johannes Weiner wrote:
> On Fri, Apr 03, 2026 at 10:08:35AM -0400, Eric Chanudet wrote:
> > Expose functions to charge/uncharge memcg with a number of pages instead
> > of a folio.
> > 
> > Signed-off-by: Eric Chanudet <echanude@redhat.com>
> 
> No naked number accounting, please. The reason existing charge paths
> require you to pass an object is because there are other memory
> attributes we need to track (such as NUMA node location).
> 

Understood, thank you.

I'll change to using a mem_cgroup_dmem_{,un}charge functions and a
memory.stat entry as well, similar to what is done for
mem_cgroup_sk_{,un}charge.

-- 
Eric Chanudet


