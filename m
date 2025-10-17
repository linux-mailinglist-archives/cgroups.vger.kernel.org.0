Return-Path: <cgroups+bounces-10879-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 12055BEB9EC
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 22:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8AB2A358021
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 20:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858E1338907;
	Fri, 17 Oct 2025 20:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WA1qRovC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D9634B41F
	for <cgroups@vger.kernel.org>; Fri, 17 Oct 2025 20:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732023; cv=none; b=TrQ1bgOFDwazVDLOwxmgLJAlWsV0COaDr0P9nWPiDntVKo/+8bL5zuoBeNOlVDauxg8C6iIBdWkLL0QgbUQcHHSocb7VRnQVaCzWDJ1BhZe19bVy5fiEwR5yx2rttKaG67/a77XQihPWnyF3Qdf/9oddts4OwVWxUQK25WFFw5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732023; c=relaxed/simple;
	bh=2DMaKOK2VXBsbJz3JTwxWGUFGZP6PnidI4mpyVFTIRU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DCcsIvdP/ChjBJxSqfoloo0gi2EYI/G64ii8WaMGb0YNZR68HkhVZnTMZeeASNiFVlpCOmsgnbjVV1MvCxKbmZ5J0B7r0w+O/mI/WWCoA2S2hTqrdQaZ/OxsCKB3Vx8It0EjX5yatuyhsKaEJSnCrpGSpHdk9e9C/8+LFwt/Q5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WA1qRovC; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3307af9b55eso2059669a91.2
        for <cgroups@vger.kernel.org>; Fri, 17 Oct 2025 13:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760732009; x=1761336809; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dmdP6R9nC9lX1jXEEElpeV73O9FQiFshjkk2aEtJ9fU=;
        b=WA1qRovCNHN2ZAT/8sz67z19z/LJuOECnGMWDiVMA/B331sLklnw5e6ERhoA/gbAtR
         QEG4dm2N5hooHB4GPOUI4GVHoirFlh5pDTIdEKlOwVbHCZaK0NfeE0nVcg2e4MhEJ3Yk
         P++bjQS3wAmLrjhhkrRGEkvYMjkpsdtGoDbrzEpEORpXZHluqOfBZnBBsqmooepxS1sE
         MGkqwVjiPjKM5V0kqygfCi+zsJFR+FBd08sTslPUcTG/Tl0VD45h8KcMG4VwiLRip/X5
         5HSgDtcMqNf0jYzW9WAGJOFdPpYeLQY9z9GWpe5rwLk2Zfha+KwskAk4sNwi9xYosCDI
         sH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732009; x=1761336809;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dmdP6R9nC9lX1jXEEElpeV73O9FQiFshjkk2aEtJ9fU=;
        b=DYBsBuuoJVI1YBtB8fi9q4VfWzql3wiIlFWnCC1ctceiHgJqyRZQWT/0CiZ6RHBprE
         UJ4HfArAFapVgMJOUU/CpqssN7nnclMDHfJiLPpqsTkJ2AJ/K8dYzBtgj9I5Ngfow+cR
         sW6+z/c/3ycMH7o/BnhFW1gZmxVSoPZqMKwBpMReraULqBEpSM1tXbSOVQnrnTZ4MZM7
         A/fOqtJk7f2GoTr7stTBJIW2C+540afNcXBTaWxNB4Y26WzeUdj7wAmqhrXeFsc0Jdvm
         pUEoGSvnUPDiGpao00G53L5pWfnDUkb4KksoppHfRXmLd5Grj59mbNuqfkLqIQbRsl5a
         UtqA==
X-Gm-Message-State: AOJu0YzXo2aGWbDys+pCQ+b61DDfBIKZIvD+rDGzTpTwOq6C9gCrlfug
	IGA5iH/XtLYVlzozw+A4pIHroGSrLrePBSZkmwOZchwTJyFpKO95m8F7EQnDZQd5GVuCNIvk9JV
	1WrtPfIZdUz9rBGVKMcmeRxdXUGfD24zYSYwxs/rxS1doDYn7FVe/wBe1DdUOsRxQfHYtXs2CnJ
	PxoMSttzCuNKlci5bW1EuSnUzyrEQVA4C52dCfRs7zOEyyh1vEIRBw3F8c8PcCLASK
X-Google-Smtp-Source: AGHT+IGzgAEN2nLVpJn47Rpink95697ahn9+YSd6/QfacQuWgps1G1sah8dROQQkq3FQWO7kCJad1FtwMfse5d5QhQ==
X-Received: from pjbsr14.prod.google.com ([2002:a17:90b:4e8e:b0:33b:8b81:9086])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:52d0:b0:33b:bed8:891e with SMTP id 98e67ed59e1d1-33bcf8fa427mr6248763a91.19.1760732009057;
 Fri, 17 Oct 2025 13:13:29 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:12:17 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <ab7645218a87a45b0f3214a07138d3c8eadd3164.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 36/37] KVM: selftests: Update pre-fault test to work
 with per-guest_memfd attributes
From: Ackerley Tng <ackerleytng@google.com>
To: cgroups@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: ackerleytng@google.com, akpm@linux-foundation.org, 
	binbin.wu@linux.intel.com, bp@alien8.de, brauner@kernel.org, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@intel.com, dave.hansen@linux.intel.com, david@redhat.com, 
	dmatlack@google.com, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	haibo1.xu@intel.com, hannes@cmpxchg.org, hch@infradead.org, hpa@zytor.com, 
	hughd@google.com, ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, 
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com, 
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, qperret@google.com, 
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com, 
	shakeel.butt@linux.dev, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

From: Sean Christopherson <seanjc@google.com>

Skip setting memory to private in the pre-fault memory test when using
per-gmem memory attributes, as memory is initialized to private by default
for guest_memfd, and using vm_mem_set_private() on a guest_memfd instance
requires creating guest_memfd with GUEST_MEMFD_FLAG_MMAP (which is totally
doable, but would need to be conditional and is ultimately unnecessary).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/pre_fault_memory_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/pre_fault_memory_test.c b/tools/testing/selftests/kvm/pre_fault_memory_test.c
index 6db75946a4f89..6bb5e52f6d948 100644
--- a/tools/testing/selftests/kvm/pre_fault_memory_test.c
+++ b/tools/testing/selftests/kvm/pre_fault_memory_test.c
@@ -188,7 +188,7 @@ static void __test_pre_fault_memory(unsigned long vm_type, bool private)
 				    private ? KVM_MEM_GUEST_MEMFD : 0);
 	virt_map(vm, gva, gpa, TEST_NPAGES);
 
-	if (private)
+	if (!kvm_has_gmem_attributes && private)
 		vm_mem_set_private(vm, gpa, TEST_SIZE);
 
 	pre_fault_memory(vcpu, gpa, 0, SZ_2M, 0, private);
-- 
2.51.0.858.gf9c4a03a3a-goog


