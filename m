Return-Path: <cgroups+bounces-15168-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Kl6IWfMz2m50gYAu9opvQ
	(envelope-from <cgroups+bounces-15168-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 03 Apr 2026 16:19:19 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0AF3951CF
	for <lists+cgroups@lfdr.de>; Fri, 03 Apr 2026 16:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B564730628C0
	for <lists+cgroups@lfdr.de>; Fri,  3 Apr 2026 14:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498703C343A;
	Fri,  3 Apr 2026 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Suv+fQKZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="O8hPjr+f"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA7132AABD
	for <cgroups@vger.kernel.org>; Fri,  3 Apr 2026 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775225596; cv=none; b=TSKgvVxXUeK3ZHevW5sJn6cSiQ54nPCWYDlTDKFxmLlQ0aILF86yCoc7m4myz2ajRQzq8TttqHYGxNQXIiKZaJbN0sNGilNKWcyQgpcVh7rhLL2en5pNO2wHAQEwC2G860XV/5DHdZWC9187Nl3YnDu4MYZPQj6hPTRig5HIQdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775225596; c=relaxed/simple;
	bh=Wy0RU0H7LQVQR4Z95trOr/a0R3UCW8jXOuycekYnywc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kfGlaytUyexvQBWVTDZrer8N/vvwbhLbExhM95ZTWfzwx8XxJVfh6eXVB3JR48/F87FciYZZ4uIXR2jZiCsQ+n7IW6KzVTk7JyJAmaIClbld6ljwqrwr5mi8FASSr3hvb43hjzR/bE8MPpQSp0Pgl0ZO9UfxEHJbBSl7jGHyAEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Suv+fQKZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=O8hPjr+f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775225592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zCsOheHk8XlC9CSFSmzc3izuiVKcS+6jE7o78F0/vE0=;
	b=Suv+fQKZFOiYRGGcw0e1oMc36UcYdbvpwqwqACxBevfQduVHtr6ZRbVywSWjuhPxt+SKq8
	OLYlDncSH+NinHc61HKdlhhwfw0pGR2z6WTOv0pSFLCyYZvoaqyuj0OTQ+OB6CbWBzHB1Z
	L51DFyDhfSwqSXFQeN9Td8uRyK2Ft5w=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-E01-exmLMjaiYfUGwPsQeA-1; Fri, 03 Apr 2026 10:13:11 -0400
X-MC-Unique: E01-exmLMjaiYfUGwPsQeA-1
X-Mimecast-MFC-AGG-ID: E01-exmLMjaiYfUGwPsQeA_1775225591
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd7de0e161so498257485a.2
        for <cgroups@vger.kernel.org>; Fri, 03 Apr 2026 07:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775225591; x=1775830391; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zCsOheHk8XlC9CSFSmzc3izuiVKcS+6jE7o78F0/vE0=;
        b=O8hPjr+fCtDUXgcUB/zEOVZ1xV4yNYOSpxepmzLRmZ8lvIsBxNh/KNSEEWH5TJbI87
         d0wRYfGUXF07uBe6xpDx178CmzumBW580FgJrM0r+yoVqO00f076QYm4ni8rsd2pQgMu
         og64tdgVsERB59dlGzuOAS1fn8L121ScRxE+7e3L8QhFJLrXrOsLzICBMK4AZNTg6l0C
         CZQw/HbfEqHsFKaTafOpMYWu9aH6jj4d300YSdn+ereLd2XnXHoTcMP/0AtPXMFphFr0
         ADHfdUO0vWtWQ69v4n8/z3larE5WApCTjt0wgCM5ipgqTQTh1bUXplJ2Kt3354pXBRtP
         nD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775225591; x=1775830391;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCsOheHk8XlC9CSFSmzc3izuiVKcS+6jE7o78F0/vE0=;
        b=WMl9VU8MyJF7Sf7ByDGLRCMDBoYztT0gDUKF2P+FIIZjf8cAoGYK2MJwRAk1eRtMd0
         L1tVqI1IWxOcpU/LJZ68oQ+9c22k7h3hRYoTkGIPXIGLLr1Pdc70Qoi3W5wPuuLUR5Lh
         T97ZyKhiduf/TFdtOmYo2LDPox8anihN8FIJv5LpSTtqi0SkfOSvlu/8X/Twpip3lilT
         Ao1inHnSo5GA7AMtfaS0WPNWcww6L0NSxNpvXEKtoDxJbqgmqbqSkFUKNrRRby/yG6ly
         MzSXCy6Y0BocI1bCJqqQ855jej3zUjImtgMYJgJLEnAb0fUYZe0NSQ8s8ZQM9g4VyNB9
         qhrQ==
X-Gm-Message-State: AOJu0YyN2C5EbboZ/RV1fbwpWIADEsTedns5yikQq4ZZ55TyFF8bCdFQ
	7k/K931yP5/+PY3NGRb+1Gt/f04jKqZKdQQwPr9xCTMpTW1hMpWiKynh++ZCAgHDen6m+9gN7Ke
	yS4mxCYX3s1YYnrX/hwtvjmgo4JusdY63/0pAoX21n6fFF9r8vw+AenHwFUk=
X-Gm-Gg: ATEYQzyHD5dGbzuKrVMaNNfoaBXzrhY40fUgDt+06nbMpimBUZbGNYj7DIm+MmVNL4M
	2NzOV6jHFZV+QAL6kUv+NRXZsaDJj4s7McmaAVhO+UhnDm9JJTnQiET80wf3obKgiH3C//VadDm
	7Ik1YbCk8TGM5u1ArerKpSQ8WaG/1aB79lH8QIeg2ZhqcNq3CjR6/VeupvwErgCtdJ6qYv8W28N
	uXTwWs5L6w1ocF7f2Ol9ssn1q/9p/YXukvoyjfrxZ0LMYyjbGNlu/hNO7Y6e4wZJHLF/AWRqD8d
	TP6zVwBxhEN6DK/xRhbtKHL0VDygAxFWH/5SRrm8vzy9/egy2iuZeil+MPzBtNVDBHnS137V7Eb
	zenjy0NJfKaEM8DpGW+WySTD9/MPQUM3aWs7UOlbKgubswqQsMHB7OALIsVv5TYo=
X-Received: by 2002:a05:620a:470d:b0:8d0:176:58bf with SMTP id af79cd13be357-8d41ec0d06emr460638185a.63.1775225590908;
        Fri, 03 Apr 2026 07:13:10 -0700 (PDT)
X-Received: by 2002:a05:620a:470d:b0:8d0:176:58bf with SMTP id af79cd13be357-8d41ec0d06emr460628785a.63.1775225590198;
        Fri, 03 Apr 2026 07:13:10 -0700 (PDT)
Received: from localhost (pool-100-17-19-56.bstnma.fios.verizon.net. [100.17.19.56])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d5336aa9f0sm21287085a.28.2026.04.03.07.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 07:13:09 -0700 (PDT)
From: Eric Chanudet <echanude@redhat.com>
Subject: [PATCH RFC 0/2] cgroup/mem: add a node to double charge in memcg
Date: Fri, 03 Apr 2026 10:08:34 -0400
Message-Id: <20260403-cgroup-dmem-memcg-double-charge-v1-0-c371d155de2a@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYyNz3eT0ovzSAt2U3NRcXSBOTtdNyS9NyknVBSovAio3SDM0MEi0TEt
 LSjNSAppSUJSallkBtiFaKcjNWSm2thYATWgic3YAAAA=
X-Change-ID: 20260327-cgroup-dmem-memcg-double-charge-0f100a9ffbf2
To: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
 Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 "T.J. Mercier" <tjmercier@google.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Maxime Ripard <mripard@redhat.com>, Albert Esteve <aesteve@redhat.com>, 
 Dave Airlie <airlied@gmail.com>, Eric Chanudet <echanude@redhat.com>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15168-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,lankhorst.se,gmx.de,suse.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.freedesktop.org,google.com,amd.com,redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[echanude@redhat.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3A0AF3951CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It was suggested previously[1] to introduce a knob for dmem region to
double charge dmem and memcg at the will of the administrator.

This RFC tries do that in the dmem controller through the cgroupfs
interface already available and walk through the problems that creates.

[1] https://lore.kernel.org/all/a446b598-5041-450b-aaa9-3c39a09ff6a0@amd.com/

Signed-off-by: Eric Chanudet <echanude@redhat.com>
---
Eric Chanudet (2):
      mm/memcontrol: add page-level charge/uncharge functions
      cgroup/dmem: add a node to double charge in memcg

 include/linux/memcontrol.h |  4 +++
 kernel/cgroup/dmem.c       | 86 ++++++++++++++++++++++++++++++++++++++++++++--
 mm/memcontrol.c            | 24 +++++++++++++
 3 files changed, 111 insertions(+), 3 deletions(-)
---
base-commit: 4b9c36c83b34f710da9573291404f6a2246251c1
change-id: 20260327-cgroup-dmem-memcg-double-charge-0f100a9ffbf2

Best regards,
-- 
Eric Chanudet <echanude@redhat.com>


