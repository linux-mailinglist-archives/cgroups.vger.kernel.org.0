Return-Path: <cgroups+bounces-10869-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCC0BEB929
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 22:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910DD19A0D65
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 20:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EBF3446B7;
	Fri, 17 Oct 2025 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sZrdZ1Z9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A203345CB0
	for <cgroups@vger.kernel.org>; Fri, 17 Oct 2025 20:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732004; cv=none; b=hb4Njky1f1EjO9C/YrKMFbg+asv+Qe4W4RmSynTJt0n41iUojZ4TYYX6j13JZ+SPUD6FzbKXcJKX4x29pooYSwCQ2PrWjE3+f1dVXsJcxRw6u9Y6jLZe4weeoPTDftI9q5usKVEQGV4jUNMfnNjZi0xCMVWOUBe0fFWKafIcUNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732004; c=relaxed/simple;
	bh=z3QufnJXtifWlXsqexaQeYQRW2Yct3n/gif5OWOyNdM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f2QxU+6mTz4gKvMQmjR1I6Ww94TYZj+64D+CE/53RoeQ0A7CKBV1x80KlJtz7Jn7KErP+Ia2FnQY0eAtc8QLg/swKe7AALMJCZspIo22WrUB2aUcgBViPxw3WmRCAT0P1dl7n5Dy9O5RqRb92g1ZKX6RGLQEV8+G+ZRG/UUkrWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sZrdZ1Z9; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33428befc49so3732742a91.0
        for <cgroups@vger.kernel.org>; Fri, 17 Oct 2025 13:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760731991; x=1761336791; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zZ34d+VZkuHwS4Tl5hmiFloUpUjtvLj/jsnwlnFoI8s=;
        b=sZrdZ1Z9gTN7fvVPurXJs+P5+sTqxUebcDa8lMe3Kuu6jpAGWCLzJWJpJLOVbdPOKl
         Kqf0PesYbsM4wb87fw/oHnfUASiedRqYuDi1bUMX3lBVNuk/eDnPwAAIyDegkpDdArr7
         uQF4Wg0SU53O8SpYjsBP9DcqC6SycJpvXvLwURAxaFQv9ac9qleg5UQyTlD4zsAcSKPF
         duGlADXNgMTu/AsjmSmmRjfehoVK+a8OsgoI5Qo1uFSxeCG8URVMp52dKuJORVugpXxJ
         nHo6S8A/AwXkmhqEITcBftEdditU+ugCDfUBiViTh6jw+0grlFARlJIK3eWOw5BANE4C
         ab2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731991; x=1761336791;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zZ34d+VZkuHwS4Tl5hmiFloUpUjtvLj/jsnwlnFoI8s=;
        b=g9Ym/Up9SiaI1RqE1/fMO2hOPSzMXPePt9r9yc+sdOTD7JkrZmkv++BKdF3eU7Dh6v
         Vp7uDHhIr67L6nFSI8bMtaLPlXBOaxtmPWiBVDVov85BYVsz0PohDLu/uY+1/mlHjusF
         QX0URDR0m5gwLmoveGQKR+VQ2zd7GYA7EmvsF/d03flL60yQWcPmZYsC3zrp+0zjjmrw
         Sg805PQK9pRthaykMYQ6SaCpprATHat/SvlY9aPO9/L7dO9JSnbBqszvp8h/3ra0OvFt
         WVl/n9dHsAFKmAHxBYAzKf7C3uX+y7kl5DK1S0B6U4YSQPtd6xBBMQr3oW1B8Ij1XCwm
         3Jcw==
X-Gm-Message-State: AOJu0YzJUghLmQaGlN6Fjc+ltBYvb0GqqB1rkvJr7ndySX2nCUotO4Ip
	BjryDHVt6sHMhtVMrxpKsUpWDVGYsL+2rgN97LcawwsfRdXUAp5+tyNcQ462EV2ExYurdCcmSYk
	YJd44GMeeXiXn2ylWI7KYOc61OCzz7VyLdRwIJWxlzxfZRHBRdFiY5+IzGGhA04pxoRwFKwy33/
	cCAu+G3bctJNiso66/oZkp55qBO8IuN5EYetNy7HHo8l77+9t7QGuYNT3Rp0KNQO5g
X-Google-Smtp-Source: AGHT+IHzx6Q3hHG57ljkrAP15mW/fSli8KOfzlU9yowcOYAMM7uKRQLpZuKh9dqK1n26N00k3XfO53kYXQVOFNP6YA==
X-Received: from pjbpj3.prod.google.com ([2002:a17:90b:4f43:b0:332:4129:51b2])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e7d0:b0:32e:23c9:6f41 with SMTP id 98e67ed59e1d1-33bc9b8dd13mr6981801a91.5.1760731989968;
 Fri, 17 Oct 2025 13:13:09 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:12:06 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <00b93a008a75a345f71b61ac67a2ffa068bc67d7.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 25/37] KVM: selftests: guest_memfd: Test that
 truncation does not change shared/private status
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

Add a test to verify that deallocating a page in a guest memfd region via
fallocate() with FALLOC_FL_PUNCH_HOLE does not alter the shared or private
status of the corresponding memory range.

When a page backing a guest memfd mapping is deallocated, e.g., by punching
a hole or truncating the file, and then subsequently faulted back in, the
new page must inherit the correct shared/private status tracked by
guest_memfd.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/guest_memfd_conversions_test.c   | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
index 43efe4af1403c..907d415d72315 100644
--- a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
@@ -10,6 +10,7 @@
 #include <linux/sizes.h>
 
 #include "kvm_util.h"
+#include "kvm_syscalls.h"
 #include "kselftest_harness.h"
 #include "test_util.h"
 #include "ucall_common.h"
@@ -316,6 +317,19 @@ GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(unallocated_folios, 8)
 		test_convert_to_shared(t, i, 'B', 'C', 'D');
 }
 
+/* Truncation should not affect shared/private status. */
+GMEM_CONVERSION_TEST_INIT_SHARED(truncate)
+{
+	host_do_rmw(t->mem, 0, 0, 'A');
+	kvm_fallocate(t->gmem_fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE, 0, page_size);
+	host_do_rmw(t->mem, 0, 0, 'A');
+
+	test_convert_to_private(t, 0, 'A', 'B');
+
+	kvm_fallocate(t->gmem_fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE, 0, page_size);
+	test_private(t, 0, 0, 'A');
+}
+
 int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));
-- 
2.51.0.858.gf9c4a03a3a-goog


