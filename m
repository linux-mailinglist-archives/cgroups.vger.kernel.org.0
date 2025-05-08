Return-Path: <cgroups+bounces-8091-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DC7AB032E
	for <lists+cgroups@lfdr.de>; Thu,  8 May 2025 20:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C211BA123F
	for <lists+cgroups@lfdr.de>; Thu,  8 May 2025 18:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F4D28A727;
	Thu,  8 May 2025 18:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="axpBAd6j"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DFD288519
	for <cgroups@vger.kernel.org>; Thu,  8 May 2025 18:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746730019; cv=none; b=IGp0VKdJcTwOu3yFa4cOmK1PDAld29PKcOWHJL0vI7kgIv6pshQz/PPKlUIuHczIVj4McC96ETYHRC/7CdKOxUjzVZePGmtbpL7INFX8QtVTNgh/1rRXLFgS9ymH7B4xrFTkswe+x6cKKH9pRE/qz8lofryxAlzYzibSs+hqps0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746730019; c=relaxed/simple;
	bh=XxmjuqNyUSH40nAiJniXWQhl/jBhBznduv5cxq5yeKs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XN6C5lH9j25sFtbD5xabuYACttuZDbKU0kcoeS0YDQYyjSxG2L9Mec8Kapa9azOxII+Bwmq4DYwxg9FD8HEdnb7YlFRARBIytjQysxln3KxqmY4SSy7LXmu3kZNSU84kyNRhcV7NAx+f2kuGZBgXKYGxG1TquTYM4sNsDPklvmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=axpBAd6j; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6e8f4367446so15291416d6.0
        for <cgroups@vger.kernel.org>; Thu, 08 May 2025 11:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746730015; x=1747334815; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uONc7WAgpVw3vuoHf0vvNHDupNr/S8j5Mtg90jyXV1Y=;
        b=axpBAd6jCM2ZSzMe6E2Ygn7EDSYK+zQ6TViyr7A9GuxcWttA5hYoXeDMh4ZfFx+phV
         v0hOUiEmDDtILH8HOViCQenUO60EoNY8PQRwZRviAyhEZIl7uMnlR8bTL/SAPgxXc5LG
         B6zCQNHIlFvmivpeP/Ikr2UeRfamCLqdc+WRPREI0rBHDIkYmzNSNyLe4oEYcfMzdPe0
         2r/smUugwpIJRnqokef15gGKBqHSjYh3vbO2nTsdkpdqguXH006kyNRmQkhtZCMFfV5G
         bNQkB0wSZgUUB+h+LQdNlzTXAMJ0/hSZr+ji2Eyp4EnrQzrb7HtMEga1HOh0KQqLVBYf
         iamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746730015; x=1747334815;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uONc7WAgpVw3vuoHf0vvNHDupNr/S8j5Mtg90jyXV1Y=;
        b=ty9qJKVU8KCkUlCbAFHQl3y+8LefU7aMio8nWnGHRJLS4VZq42mAZZACoP/2S7S7ci
         ov86e+0Li+M6hLam26FQ7Qr0ZKH+fd6+5lhMXAGOrqdBYLziKb1PwTkNkAhZy4eLHHW0
         M3lSGbzVVjroXJV2mYBYGGxYeq54VEGJ01rxsmmk1Hn0LFgJLW1hZaYiIXr0Aiy8iDJE
         i6j2JezhQX2ejss30EyifnzqcKCsBfE7+PdEPuLpbeRlvLvOPK2Mz9m92jBZxOpdiIJN
         Nb6eAq7wcasZBrI8q5aaE651sTJ/Z22VJ3m/fK/ka76j3PdV1JYjuU86qma0Pknw2Kq2
         IUXw==
X-Forwarded-Encrypted: i=1; AJvYcCW/m1mqs1AxL7tjUt0xyJZUUt8ZIJIrlUcyXG0C3mOktOYsxJaGBWxmvQ49cw9DxjN9w52c44Zi@vger.kernel.org
X-Gm-Message-State: AOJu0YygAVlzgnBrxNu5SdM1uBGTvZPATp2QYSnG5KO11EEVu17CV5jV
	m/MjPQFtr0gUAais6AQed0SzCj8VylLEv+cU4/FlXsIcfSw9XopygOD8to9KQolHxCXlgvWZGN1
	/nMHLGBB5OKbFh0gp9A==
X-Google-Smtp-Source: AGHT+IHCSF3WPWtWHvI8KIBlSC7FdHqt0IH8/ghvMwVjrKFTrdvoF62AI1U/UII2RXUtP23ELsj30SazWDnfhkbF
X-Received: from qvblr6.prod.google.com ([2002:a05:6214:5bc6:b0:6f2:b7f7:aeaf])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:45ac:0:b0:6f5:3f55:343c with SMTP id 6a1803df08f44-6f6e480e25bmr4365056d6.32.1746730015502;
 Thu, 08 May 2025 11:46:55 -0700 (PDT)
Date: Thu,  8 May 2025 18:46:47 +0000
In-Reply-To: <20250508184649.2576210-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250508184649.2576210-1-jthoughton@google.com>
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
Message-ID: <20250508184649.2576210-7-jthoughton@google.com>
Subject: [PATCH v4 6/7] KVM: selftests: Build and link selftests/cgroup/lib
 into KVM selftests
From: James Houghton <jthoughton@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, mkoutny@suse.com, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Yu Zhao <yuzhao@google.com>, 
	David Matlack <dmatlack@google.com>, James Houghton <jthoughton@google.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

libcgroup.o is built separately from KVM selftests and cgroup selftests,
so different compiler flags used by the different selftests will not
conflict with each other.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index f62b0a5aba35a..bea746878bcaa 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -204,6 +204,7 @@ OVERRIDE_TARGETS = 1
 # importantly defines, i.e. overwrites, $(CC) (unless `make -e` or `make CC=`,
 # which causes the environment variable to override the makefile).
 include ../lib.mk
+include ../cgroup/lib/libcgroup.mk
 
 INSTALL_HDR_PATH = $(top_srcdir)/usr
 LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
@@ -257,7 +258,7 @@ LIBKVM_S := $(filter %.S,$(LIBKVM))
 LIBKVM_C_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_C))
 LIBKVM_S_OBJ := $(patsubst %.S, $(OUTPUT)/%.o, $(LIBKVM_S))
 LIBKVM_STRING_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_STRING))
-LIBKVM_OBJS = $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ) $(LIBKVM_STRING_OBJ)
+LIBKVM_OBJS = $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ) $(LIBKVM_STRING_OBJ) $(LIBCGROUP_O)
 SPLIT_TEST_GEN_PROGS := $(patsubst %, $(OUTPUT)/%, $(SPLIT_TESTS))
 SPLIT_TEST_GEN_OBJ := $(patsubst %, $(OUTPUT)/$(ARCH)/%.o, $(SPLIT_TESTS))
 
-- 
2.49.0.1015.ga840276032-goog


