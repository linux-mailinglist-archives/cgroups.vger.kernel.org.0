Return-Path: <cgroups+bounces-11220-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE26C12029
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 00:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1C664FB045
	for <lists+cgroups@lfdr.de>; Mon, 27 Oct 2025 23:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268C9334694;
	Mon, 27 Oct 2025 23:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="acx+GaZ/"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E651333439A
	for <cgroups@vger.kernel.org>; Mon, 27 Oct 2025 23:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607370; cv=none; b=R1/vZeRGBURPN9wK0lzkVej7cdiudVSd58E7mMRF9ogaR0s5PBbSB4fXYBJPRWDhupY4FL2Ssp1HjGcyAoKCa5OrErmdbjPJNmPI+hCVCj4T8SHKlRmOtn7LKCAeX0VnHb7jMkdo92l0MVcTqZAyN1fxNeEnsnEpKvRx8IIxmiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607370; c=relaxed/simple;
	bh=EOq16WDC/pDdVV0rUatnzK+ovi3ANgmsXklP37Zgh4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqTqLpXdWaIza9kwG5Z0DsMW0/d+nTzu5PHjcfnVmEeH2vFhn5ip8KPqolAAfoETwrX+mheAsJkzx6AmB5B5PmYWAnfhf1YydIWTalkI+89TrOc62Q0OnXBPuN1y1CAIC6eL12PnYa+mAt2ICF1raZG1jyoR8uAUPOvoLXnstxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=acx+GaZ/; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761607367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rJ5jF1KqqBtpRr4lYaVGPUnGDQslbYhlpMRXuPv0AtM=;
	b=acx+GaZ/3IyRJBXp7KA1NErrPT//rMvPKOxJHJZoj5KpfXo9fjcmBYbgjKgqG6BVB5kRXl
	DtpNkULE9kwRHtW+fa8iZuz/RQQyN/Gkncab8G5m595kp90vn7WBM+GZ9LtPi0+cpouzWD
	WWt6B9Fc88j+Q3xIvgjeoaHogKqZLVE=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v2 17/23] bpf: selftests: introduce read_cgroup_file() helper
Date: Mon, 27 Oct 2025 16:22:00 -0700
Message-ID: <20251027232206.473085-7-roman.gushchin@linux.dev>
In-Reply-To: <20251027232206.473085-1-roman.gushchin@linux.dev>
References: <20251027232206.473085-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Implement read_cgroup_file() helper to read from cgroup control files,
e.g. statistics.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 tools/testing/selftests/bpf/cgroup_helpers.c | 39 ++++++++++++++++++++
 tools/testing/selftests/bpf/cgroup_helpers.h |  2 +
 2 files changed, 41 insertions(+)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 20cede4db3ce..8fb02fe4c4aa 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -126,6 +126,45 @@ int enable_controllers(const char *relative_path, const char *controllers)
 	return __enable_controllers(cgroup_path, controllers);
 }
 
+static size_t __read_cgroup_file(const char *cgroup_path, const char *file,
+				 char *buf, size_t size)
+{
+	char file_path[PATH_MAX + 1];
+	size_t ret;
+	int fd;
+
+	snprintf(file_path, sizeof(file_path), "%s/%s", cgroup_path, file);
+	fd = open(file_path, O_RDONLY);
+	if (fd < 0) {
+		log_err("Opening %s", file_path);
+		return -1;
+	}
+
+	ret = read(fd, buf, size);
+	close(fd);
+	return ret;
+}
+
+/**
+ * read_cgroup_file() - Read to a cgroup file
+ * @relative_path: The cgroup path, relative to the workdir
+ * @file: The name of the file in cgroupfs to read to
+ * @buf: Buffer to read from the file
+ * @size: Size of the buffer
+ *
+ * Read to a file in the given cgroup's directory.
+ *
+ * If successful, the number of read bytes is returned.
+ */
+size_t read_cgroup_file(const char *relative_path, const char *file,
+			char *buf, size_t size)
+{
+	char cgroup_path[PATH_MAX - 24];
+
+	format_cgroup_path(cgroup_path, relative_path);
+	return __read_cgroup_file(cgroup_path, file, buf, size);
+}
+
 static int __write_cgroup_file(const char *cgroup_path, const char *file,
 			       const char *buf)
 {
diff --git a/tools/testing/selftests/bpf/cgroup_helpers.h b/tools/testing/selftests/bpf/cgroup_helpers.h
index 3857304be874..9f9bb6b5d992 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.h
+++ b/tools/testing/selftests/bpf/cgroup_helpers.h
@@ -11,6 +11,8 @@
 
 /* cgroupv2 related */
 int enable_controllers(const char *relative_path, const char *controllers);
+size_t read_cgroup_file(const char *relative_path, const char *file,
+			char *buf, size_t size);
 int write_cgroup_file(const char *relative_path, const char *file,
 		      const char *buf);
 int write_cgroup_file_parent(const char *relative_path, const char *file,
-- 
2.51.0


