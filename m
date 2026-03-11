Return-Path: <cgroups+bounces-14758-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ME+tAMcssWkBrgIAu9opvQ
	(envelope-from <cgroups+bounces-14758-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 09:50:15 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B25C25FB64
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 09:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 29212301EA3F
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 08:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A97D3B9D89;
	Wed, 11 Mar 2026 08:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WxZtBfmn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jx1JxbEt"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5823C2794
	for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 08:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773218992; cv=pass; b=bI63v7HBMPOtFaJJonDyCTuxd+RWFn3DR80oCqX4LSts+tx32n3fTJ14h45hlOlWWSlm7pjF/HTfn5MRSnlOTbaF5Ru4v4r1PtLyRLnWZB7pF49kUyBDrdi5YYZTcwyweqckGmR/sK78TrCJqg8iOzEAjMKmqjBUpNx9Ta3oVPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773218992; c=relaxed/simple;
	bh=Qo7WbD1QbdNemF38QHPtSbMk0ng5osXjI0DVE3wZsWQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=CSwyWZ5MNhYkZubp8QHH/yIG9crLbYOE2jMcTLln+3pnT/jXQJvV1kWCcIps1mxbq/hGBOfBrMdDr4SmGKQR0zvImXKiaaUr2pyskh9HJxCuRfalYMjGJLXh7HkMW3ksx54ePkL6l+NEDX4yVGPkMvhVzftdx3CU+0EHiSN8u/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WxZtBfmn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jx1JxbEt; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773218985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=Qo7WbD1QbdNemF38QHPtSbMk0ng5osXjI0DVE3wZsWQ=;
	b=WxZtBfmnJf6oXUj9VnlnNZ64RVE4upyHGYOxpWap+eyL8hpRzPN/f42ryW+zFLFtDkbGQw
	hOYv6BIPZXevEbiq7Clap9WXEAclI74ZWdXAaE9I5LAxvVfZ8Lh9RGuVXh9D/g2iPWArxP
	NG27aOChB7hjyhB9tllFZTkn/HzXb/k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-CfRBMpiYNs25-F_0s8n0UA-1; Wed, 11 Mar 2026 04:49:44 -0400
X-MC-Unique: CfRBMpiYNs25-F_0s8n0UA-1
X-Mimecast-MFC-AGG-ID: CfRBMpiYNs25-F_0s8n0UA_1773218983
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b96edb0feeaso289766266b.1
        for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 01:49:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773218983; cv=none;
        d=google.com; s=arc-20240605;
        b=k/aN3+tM3s2MF+ZoTRb4bv7lgci9HJQktGxR0CXQey8aqFlnb3f0zH7AbBUY4xaWC/
         XPEXo9djJNs6zO5w1KHrlWlbs2c6TFd0aDdsoIjB9UZwRs3XolsLFMyOd2Uy6t54nsDz
         /RFWD2D+MwFIHPynss5Q/bICMexJl8bdlKN28A88kB9hjoH2MooEEqlr/i7yPJDIfzqN
         y1/FPvcpO/GIamGFh6i1n2IzJ6GeHFD7kOEmKks3ivmirVIIq3g+yn/0rlqWJyenBEBS
         R5Ve9CEfsJxwRoM1MLd29ISybmjFFCwTVQj2FEuF0mErxYw0u8O5pnedSo1XhOaxVA0o
         J0UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Qo7WbD1QbdNemF38QHPtSbMk0ng5osXjI0DVE3wZsWQ=;
        fh=/VRlkVNHEsrQ9zqVZXnAg8lRt77OVKWaLx0DQfkmUoM=;
        b=gcsprzls8UfUP2gK4QeCTCxJOuGxSUMjAh0cS9U58OGl0GKamEf9U3Dz3u3F9DHKmw
         pBdtS/IDGfj3IEI0fzuW2gkYzPrfDry9UmoPKLbg91bP4ZUMZR25S9FidwAgmCUQZefP
         Mq2dOjlVkRPGxw6xrJenqnk8+jrTn5ERdqyjkWlRlHZ2bttSA6heR2kYxdEuWMSwRViE
         Yshnp0+je/EdBzocuR1wF5L2TUayb4BLbGXu3+ItPSdiuMHA2gdxvUHauzxBC8Z0YJp8
         batgy3Ki/dQdccdnQeou9GjtwEal1YiJqfLrCU38vYoVVYhfZq+2+leDyCCmDKsTkG+L
         QaVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773218983; x=1773823783; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qo7WbD1QbdNemF38QHPtSbMk0ng5osXjI0DVE3wZsWQ=;
        b=Jx1JxbEtayeQTehXEH54bsK86pZWqev2rU6um8eTOAbSz0uoimGasPOOKgei3F24+w
         s/fc5eiYlcpES34v8cZJxLlt1F7TOpndwd/aeOBoF4pSdXBfWlb7Tohqbc7yKqzVy2uZ
         2EUnkQv32lzW01TCIPgX39FlOP8uQIis/VBFk5aDQcLox0L/AX8+iris6JtkWX/YNWvr
         Fv1weR8ZPVfbIaUZy7/rUNuoVT95Cgls1nUcAOV9GAJvqYGofov47b75oEDDbtxghGhb
         vmFZWN6LL2XdsqguKVbUVmhukAqXcQr+VNttA7y2VekSkyV3OMvjK7pRpizUr6Dv7WiN
         CTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773218983; x=1773823783;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qo7WbD1QbdNemF38QHPtSbMk0ng5osXjI0DVE3wZsWQ=;
        b=GrafdBaUtWqR9abBhwwiWAy4K1r2RXXj5w9GOezE16rUI/mH1ofIcVtDvpK0PYruQE
         38zcuOYFzoQfbcbmfaDbImA+0dhed5W5KJQKKW7q5Jm7bqS0if/0jpgWCsH6bIdA2BKV
         ZoZhvYdySzxIHX8hmbutmRBXuS/tOYPFyP5jxzoKfjLsT/A75W3NjNLudARljyuA+R8M
         4JvwXvb1ESXsofrgK59h6E4Sxf2nRsJrBfNwnipYUZOJLgUPmjYdmd/ywjSwF2dvqSt+
         xWXZtB9cCdzZsUpNuFS3vjjT4ceqqa/KXLD8FfxCgJgMNKph4j+AnIdYExKlFI6CO+N+
         Wo4A==
X-Gm-Message-State: AOJu0YyQkeuP+8m94k5r18OWS2AVGZiVjg4O24IL+8U7T91aHfvykyar
	zT4nPpilofRFiK3pTeqXj9stnqEWwnK32wEwmsbc5PeSOXg0U/AfTPjf5N9bP1i+mKU72DnipsO
	UpAWtGK4zqfm2/BFISuMg26qEX/1ljgZp/g/ZDjS4CCBRJp4eV+bkH32lo2RJpaw2zsF/7filHC
	8eabbSCVibTk2oMh3Vs0vQuHvVUI1W+zC0/NwtGayt9JjWX9Nn1g==
X-Gm-Gg: ATEYQzx1mP/PwRkD94dnzgcSYbTtfUhLj9tODt1yhZM2bXai7s4cbbfPk6vAgBMLN1t
	Kwh+vStlq8aKXYit9AL8MNyXeRNVQlUSr+xOpCItKbpQFj6EX2EhDdBhvNRPeDjuojAdFPTd6Ft
	JLfxADeZRLWIQ4K1gvl7R1YRivTzt9XcUtApoX+duu93hOF7dPrwzHPUtiL35UhYudYzf6jE0Xh
	Lcs584=
X-Received: by 2002:a17:907:1b13:b0:b88:5bbc:3658 with SMTP id a640c23a62f3a-b972e5a2d9amr90241066b.52.1773218982711;
        Wed, 11 Mar 2026 01:49:42 -0700 (PDT)
X-Received: by 2002:a17:907:1b13:b0:b88:5bbc:3658 with SMTP id
 a640c23a62f3a-b972e5a2d9amr90238966b.52.1773218982184; Wed, 11 Mar 2026
 01:49:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lucas Liu <hongzliu@redhat.com>
Date: Wed, 11 Mar 2026 16:49:31 +0800
X-Gm-Features: AaiRm50MpBmDYcuIM3Ue2rspwscP1maHNKx8QhP8fX5PDlXRPos8qDnvink7D2o
Message-ID: <CAEnjF8FxM2CGgGC0R42R7R4=udHMtkwV9bCVcw7NDq7KTZMLkg@mail.gmail.com>
Subject: [ISSUE] cgroup: test_percpu_basic fails on PREEMPT_RT due to lazy
 percpu stat flushing
To: cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 4B25C25FB64
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14758-lists,cgroups=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hongzliu@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi recently I met this issue
 ./test_kmem
ok 1 test_kmem_basic
ok 2 test_kmem_memcg_deletion
ok 3 test_kmem_proc_kpagecgroup
ok 4 test_kmem_kernel_stacks
ok 5 test_kmem_dead_cgroups
memory.current 24514560
percpu 15280000
not ok 6 test_percpu_basic

In this test the memory.current 24514560, percpu 15280000, Diff ~9.2MB.

#define MAX_VMSTAT_ERROR (4096 * 64 * get_nprocs())

in this part (8cpus) MAX_VMSTAT_ERROR is 4M memory. On the RT kernel,
the labs(current - percpu) is 9.2M, that is the root cause for this
failure. I am not sure what value is suitable for this case(2M per cpu
maybe?)


