Return-Path: <cgroups+bounces-8089-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E44AB0328
	for <lists+cgroups@lfdr.de>; Thu,  8 May 2025 20:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA474189A6E1
	for <lists+cgroups@lfdr.de>; Thu,  8 May 2025 18:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF76C288C93;
	Thu,  8 May 2025 18:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3pTU088t"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ua1-f74.google.com (mail-ua1-f74.google.com [209.85.222.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19452882D1
	for <cgroups@vger.kernel.org>; Thu,  8 May 2025 18:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746730017; cv=none; b=FqDcq+x4X5qLUKEG8qtB+McP/IMSwUtid0MDebBFmsEbnKrJvCzwGyWxUZEb7S99jLCwxzOpZzXMfe1uPQdDE/n5xYVlDRxarth8YdWKj6uDuY6VHZR95JD0PqwDYp4332uwojAgcXrodSnVrhqx6T8RBW85Lr5k1Ch2ynrkYkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746730017; c=relaxed/simple;
	bh=pIVHOeltDOBLl2WJPbpjxuiQl2m85diWEjVbTSjOxCQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rcc/yCahJ44BLAcN41DuwWl7fHC/K+xlEOIRG5yfGoCsPvFT0PSp0bXDuCgS4JZY2e8aXCcilIZ8bsEOuluGh/1YYPQnxDJkXaHadKc4c2o/1KVq8Wa00XHCoIFQ7HRgEpvRj5ExEHRU9yUVoVH9lseMuV0773IyhhDp4J/l6Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3pTU088t; arc=none smtp.client-ip=209.85.222.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-ua1-f74.google.com with SMTP id a1e0cc1a2514c-877b7ebb548so923047241.1
        for <cgroups@vger.kernel.org>; Thu, 08 May 2025 11:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746730015; x=1747334815; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TPkcI+kCU+4Iqs2BRj8Yz0fZ6778cjSBpMNFBoleiKE=;
        b=3pTU088tAziygbxrMHYuIgXUZprP/Q7Daxa+iY7gvgGNOS/NrgseZenM5Amh8fnJ1B
         i2iAS8SEPPmsIla04NcJJpgfuZBXWCIZsfWeeUyLoYYDlnFQmZTnFZNHf7IvqR1ZYh3C
         OoahSV1u836SxaURLwLdx0qbXtJ6TrK1iyhLkthz0r0GY/h3JvM09AmnasHNF9BEWVAM
         2cy4WedBb/5E6Nnzl7k1VNGNx+DLFettrvNyhspHj/A47WQp0OXteGxss5sKGUUbIqmJ
         macBXW7stBn/3G7NOoTp1x7hNxePpyrqRFLBTHTxsmt2tSKLj/c9RwDgK6TlMdKeOWos
         vPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746730015; x=1747334815;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPkcI+kCU+4Iqs2BRj8Yz0fZ6778cjSBpMNFBoleiKE=;
        b=rR9eczP0L+2R+ye5iyUO2X2mdw8u3vnHllkABlcEpSt5s98x43GaCxFO/1cNd/v78Q
         gXT8ZliHYSMauQ1YORI7i7v487MdTXyelKU/qDG6feMWAFNuV7yn0vq0Fha30fJOmF/+
         KFSUC4FrajDFIOYOjrem9rJ9a77okRJcEbH0v0qTlRqe0mMhQplW0r/dAUpiIOnhK5hJ
         y6G4UOL++V7xXQJhZTXQx+jc1wdpiSs20o+AHk+OLTqOcCOlo9lM1IJrR09299x2qhTm
         SLsYrhm3eJxYUsUe3PQLaojxQOkp8/KtBj6y0Dnvvlk/HF6Q2pkwDlroYgqiovXN3804
         cpOw==
X-Forwarded-Encrypted: i=1; AJvYcCWibXoVp3Z3kP9lwTgrN8+A6T2M/MDAOrHmWOA8Hr2dm8TqztY68hkefzndsVqoKI8BRMmFk05t@vger.kernel.org
X-Gm-Message-State: AOJu0YwUq9k6+dZR14L34AFjkgwsr6S2Bjn3R7QXbCuJtDHdmDYGOm5a
	vFwTjvOMcvNLyOHMH+VOqdLXCfn96PzH+904vCbKy87JjSK8AiWN70LFZ8ZXDuD6L/o4B7wQ7Oj
	cuRZisP0R4Z29n545vw==
X-Google-Smtp-Source: AGHT+IH4jloYyqMQYt/c6wOYxAFh3MZtC8q8yjTVGigRDrHGekdZZHmBnb8TqkSl8QUx+cSBb+kiytSFdKZf7Wwu
X-Received: from uabht8.prod.google.com ([2002:a05:6130:4f88:b0:877:add4:6ac3])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:15a0:b0:4c3:6979:2ef with SMTP id ada2fe7eead31-4deed3e7b59mr624443137.21.1746730014791;
 Thu, 08 May 2025 11:46:54 -0700 (PDT)
Date: Thu,  8 May 2025 18:46:46 +0000
In-Reply-To: <20250508184649.2576210-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250508184649.2576210-1-jthoughton@google.com>
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
Message-ID: <20250508184649.2576210-6-jthoughton@google.com>
Subject: [PATCH v4 5/7] cgroup: selftests: Add API to find root of specific controller
From: James Houghton <jthoughton@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, mkoutny@suse.com, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Yu Zhao <yuzhao@google.com>, 
	David Matlack <dmatlack@google.com>, James Houghton <jthoughton@google.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Sean Christopherson <seanjc@google.com>

Add an API in the cgroups library to find the root of a specific
controller.  KVM selftests will use the API to find the memory controller.

Search for the controller on both v1 and v2 mounts, as KVM selftests'
usage will be completely oblivious of v1 versus v2.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: James Houghton <jthoughton@google.com>
---
 .../selftests/cgroup/lib/cgroup_util.c        | 34 +++++++++++++++----
 .../cgroup/lib/include/cgroup_util.h          |  1 +
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/cgroup/lib/cgroup_util.c b/tools/testing/selftests/cgroup/lib/cgroup_util.c
index 4b975637351b2..8832f3d1cb614 100644
--- a/tools/testing/selftests/cgroup/lib/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/lib/cgroup_util.c
@@ -217,7 +217,8 @@ int cg_write_numeric(const char *cgroup, const char *control, long value)
 	return cg_write(cgroup, control, buf);
 }
 
-int cg_find_unified_root(char *root, size_t len, bool *nsdelegate)
+static int cg_find_root(char *root, size_t len, const char *controller,
+			bool *nsdelegate)
 {
 	char buf[10 * PAGE_SIZE];
 	char *fs, *mount, *type, *options;
@@ -236,18 +237,37 @@ int cg_find_unified_root(char *root, size_t len, bool *nsdelegate)
 		options = strtok(NULL, delim);
 		strtok(NULL, delim);
 		strtok(NULL, delim);
-
-		if (strcmp(type, "cgroup2") == 0) {
-			strncpy(root, mount, len);
-			if (nsdelegate)
-				*nsdelegate = !!strstr(options, "nsdelegate");
-			return 0;
+		if (strcmp(type, "cgroup") == 0) {
+			if (!controller || !strstr(options, controller))
+				continue;
+		} else if (strcmp(type, "cgroup2") == 0) {
+			if (controller &&
+					cg_read_strstr(mount, "cgroup.controllers", controller))
+				continue;
+		} else {
+			continue;
 		}
+		strncpy(root, mount, len);
+
+		if (nsdelegate)
+			*nsdelegate = !!strstr(options, "nsdelegate");
+		return 0;
+
 	}
 
 	return -1;
 }
 
+int cg_find_controller_root(char *root, size_t len, const char *controller)
+{
+	return cg_find_root(root, len, controller, NULL);
+}
+
+int cg_find_unified_root(char *root, size_t len, bool *nsdelegate)
+{
+	return cg_find_root(root, len, NULL, nsdelegate);
+}
+
 int cg_create(const char *cgroup)
 {
 	return mkdir(cgroup, 0755);
diff --git a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
index b7006dc761aba..adb2bc1931839 100644
--- a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
@@ -24,6 +24,7 @@ static inline int values_close(long a, long b, int err)
 extern ssize_t read_text(const char *path, char *buf, size_t max_len);
 extern ssize_t write_text(const char *path, char *buf, ssize_t len);
 
+extern int cg_find_controller_root(char *root, size_t len, const char *controller);
 extern int cg_find_unified_root(char *root, size_t len, bool *nsdelegate);
 extern char *cg_name(const char *root, const char *name);
 extern char *cg_name_indexed(const char *root, const char *name, int index);
-- 
2.49.0.1015.ga840276032-goog


