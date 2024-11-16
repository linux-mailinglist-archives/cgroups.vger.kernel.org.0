Return-Path: <cgroups+bounces-5593-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B39899D002D
	for <lists+cgroups@lfdr.de>; Sat, 16 Nov 2024 19:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69D4828734B
	for <lists+cgroups@lfdr.de>; Sat, 16 Nov 2024 18:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C352E199E92;
	Sat, 16 Nov 2024 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="xSLgKRvq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5B4193416
	for <cgroups@vger.kernel.org>; Sat, 16 Nov 2024 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731779971; cv=none; b=r1j5nCgyVh2ks0FsmuYre4iZyeQQ01otKuK4iCXn441tjGO+e+rjvHPdQH+GF/2oukLZkiOGanfJUUKOBYUb7ar5MrVRcpf6cxILpRDJpt59wup0GQGbF8/Ntr713IwWosAOx/vf4q9bnWqOo2uxaYjZydLp8KL08/WDrRHUDTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731779971; c=relaxed/simple;
	bh=lfJrkQU7kDKAcbgAg+MX5GusICFlw92JF3DwO3UuDT0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ra+RoX+kGyPQidKClvNfihNbaE2Xyv5IoartOdSTUJdp8Q8IXn1KYboVMr9P+ZqIVOoZ/YaZpD2Kp1kpZwXpTEb9Jb3hL0HZ+82bjuiKQnZ0TWi8p4e+4oFG3YBVb4xbl4P5ORQR3MoB6bBRoCz4zyMSQCJ74b3jRdVqcCphdfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=xSLgKRvq; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b15467f383so122266085a.3
        for <cgroups@vger.kernel.org>; Sat, 16 Nov 2024 09:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1731779968; x=1732384768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q+AdtzJV8StRb0yy8pEXghurQ0eEZGVtS6O69RbdSyA=;
        b=xSLgKRvq2J3aFK5p2JVdxbkHbQzrBADD+qUNuUzCr9f7Ryktdoi1aafaEp7jaaG1Ny
         uwFOpin86TL9/Yd052RzVYfnaJZ/IScJPIhV91qJ89ErkdcuoIiqjIYZSIzg6+jQ3DaN
         tD0QpS6Kq8l3ocpuZ/aid4OQ59jdZ0QNxCqXL91+gL9z8VvUVcccmvucwmqpYBqKsbrl
         qka94THxQJyK4RmOAULJ9vSPrSxgOF4XeFlSGU0/6Dnv8UVGYxHb9KVpRq2sjSP4fb/x
         ScN7lNwuBRug+LnMECmSD1M6HgOnrZIL327Vm9HdbBUuZrp+gn6soQvjPXZiSm2PmOnD
         Y69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731779968; x=1732384768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+AdtzJV8StRb0yy8pEXghurQ0eEZGVtS6O69RbdSyA=;
        b=BeTXwLJeT653cdKMax1b8imqNHzeGwRP2wtm3gWaCuUk1nC7WZt3CYXrkglJ1EOg8R
         +tA/TF/YoUUTQ3ar9PHptmwJso3QUdf65rEHs+dDjq7M1VX9Mtyf8g8mkBrG/NqUu+u2
         GvKJHr6Z0TC9++R4kNW3+bMCCJF/W+o+hNgoNx0IE5cEkG086u/wxe7QILJI9GXxhH8C
         up/bkklnaKJhKY74p5jbfxj9bEzazcTvnRLJTuEDWhB/UiiNNKNeiw+ZwclfE2EPnCKQ
         hHX9EGVkEJ5vvjdQ87ESaYmXCmQhqTCoUhqeDmV1ZKAVJzZeLqV+X5CvYmMRbLuPv4uG
         PfdA==
X-Forwarded-Encrypted: i=1; AJvYcCUMTiXiou/AvwUANVbk5dJGaPa55kkqb1YpI2kC9PhMt3pSQZyXWc0OtvsltjxV6f3NGbpo6dyv@vger.kernel.org
X-Gm-Message-State: AOJu0YxnpfTVoBrpkbRzRrNewS2+kaKQSXIHkDjKUwCHsE5wqFI/VrX7
	RNL1hWaEznwaQTPxHiyx+/5ungt3irYiioaDqMKmUQDTAfp1oeYovTirk8sToIw=
X-Google-Smtp-Source: AGHT+IHID5UaFDu345/iXR65Tjm/g4UasFabizEe9rsgDtnAMppuhhS2EDxuUbmo+8naXZvVw6Ss7Q==
X-Received: by 2002:a05:620a:468d:b0:7b1:5504:2772 with SMTP id af79cd13be357-7b362378df6mr1035738885a.55.1731779967540;
        Sat, 16 Nov 2024 09:59:27 -0800 (PST)
Received: from soleen.c.googlers.com.com (51.57.86.34.bc.googleusercontent.com. [34.86.57.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35ca309d6sm280530085a.94.2024.11.16.09.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 09:59:26 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pasha.tatashin@soleen.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	derek.kiernan@amd.com,
	dragan.cvetic@amd.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	vbabka@suse.cz,
	jannh@google.com,
	shuah@kernel.org,
	vegard.nossum@oracle.com,
	vattunuru@marvell.com,
	schalla@marvell.com,
	david@redhat.com,
	willy@infradead.org,
	osalvador@suse.de,
	usama.anjum@collabora.com,
	andrii@kernel.org,
	ryan.roberts@arm.com,
	peterx@redhat.com,
	oleg@redhat.com,
	tandersen@netflix.com,
	rientjes@google.com,
	gthelen@google.com
Subject: [RFCv1 1/6] mm: Make get_vma_name() function public
Date: Sat, 16 Nov 2024 17:59:17 +0000
Message-ID: <20241116175922.3265872-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Page Detective will be using get_vma_name() that is currently used by
fs/proc to show names of VMAs in /proc/<pid>/smaps for example.

Move this function to mm/vma.c, and make it accessible by modules.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 fs/proc/task_mmu.c | 61 ----------------------------------------------
 include/linux/fs.h |  3 +++
 mm/vma.c           | 60 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 61 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e52bd96137a6..b28c42b7a591 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -240,67 +240,6 @@ static int do_maps_open(struct inode *inode, struct file *file,
 				sizeof(struct proc_maps_private));
 }
 
-static void get_vma_name(struct vm_area_struct *vma,
-			 const struct path **path,
-			 const char **name,
-			 const char **name_fmt)
-{
-	struct anon_vma_name *anon_name = vma->vm_mm ? anon_vma_name(vma) : NULL;
-
-	*name = NULL;
-	*path = NULL;
-	*name_fmt = NULL;
-
-	/*
-	 * Print the dentry name for named mappings, and a
-	 * special [heap] marker for the heap:
-	 */
-	if (vma->vm_file) {
-		/*
-		 * If user named this anon shared memory via
-		 * prctl(PR_SET_VMA ..., use the provided name.
-		 */
-		if (anon_name) {
-			*name_fmt = "[anon_shmem:%s]";
-			*name = anon_name->name;
-		} else {
-			*path = file_user_path(vma->vm_file);
-		}
-		return;
-	}
-
-	if (vma->vm_ops && vma->vm_ops->name) {
-		*name = vma->vm_ops->name(vma);
-		if (*name)
-			return;
-	}
-
-	*name = arch_vma_name(vma);
-	if (*name)
-		return;
-
-	if (!vma->vm_mm) {
-		*name = "[vdso]";
-		return;
-	}
-
-	if (vma_is_initial_heap(vma)) {
-		*name = "[heap]";
-		return;
-	}
-
-	if (vma_is_initial_stack(vma)) {
-		*name = "[stack]";
-		return;
-	}
-
-	if (anon_name) {
-		*name_fmt = "[anon:%s]";
-		*name = anon_name->name;
-		return;
-	}
-}
-
 static void show_vma_header_prefix(struct seq_file *m,
 				   unsigned long start, unsigned long end,
 				   vm_flags_t flags, unsigned long long pgoff,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3559446279c1..a25b72397af5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3474,6 +3474,9 @@ void setattr_copy(struct mnt_idmap *, struct inode *inode,
 
 extern int file_update_time(struct file *file);
 
+void get_vma_name(struct vm_area_struct *vma, const struct path **path,
+		  const char **name, const char **name_fmt);
+
 static inline bool vma_is_dax(const struct vm_area_struct *vma)
 {
 	return vma->vm_file && IS_DAX(vma->vm_file->f_mapping->host);
diff --git a/mm/vma.c b/mm/vma.c
index 7621384d64cf..1bd589fbc3c7 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2069,3 +2069,63 @@ void mm_drop_all_locks(struct mm_struct *mm)
 
 	mutex_unlock(&mm_all_locks_mutex);
 }
+
+void get_vma_name(struct vm_area_struct *vma, const struct path **path,
+		  const char **name, const char **name_fmt)
+{
+	struct anon_vma_name *anon_name = vma->vm_mm ? anon_vma_name(vma) : NULL;
+
+	*name = NULL;
+	*path = NULL;
+	*name_fmt = NULL;
+
+	/*
+	 * Print the dentry name for named mappings, and a
+	 * special [heap] marker for the heap:
+	 */
+	if (vma->vm_file) {
+		/*
+		 * If user named this anon shared memory via
+		 * prctl(PR_SET_VMA ..., use the provided name.
+		 */
+		if (anon_name) {
+			*name_fmt = "[anon_shmem:%s]";
+			*name = anon_name->name;
+		} else {
+			*path = file_user_path(vma->vm_file);
+		}
+		return;
+	}
+
+	if (vma->vm_ops && vma->vm_ops->name) {
+		*name = vma->vm_ops->name(vma);
+		if (*name)
+			return;
+	}
+
+	*name = arch_vma_name(vma);
+	if (*name)
+		return;
+
+	if (!vma->vm_mm) {
+		*name = "[vdso]";
+		return;
+	}
+
+	if (vma_is_initial_heap(vma)) {
+		*name = "[heap]";
+		return;
+	}
+
+	if (vma_is_initial_stack(vma)) {
+		*name = "[stack]";
+		return;
+	}
+
+	if (anon_name) {
+		*name_fmt = "[anon:%s]";
+		*name = anon_name->name;
+		return;
+	}
+}
+EXPORT_SYMBOL_GPL(get_vma_name);
-- 
2.47.0.338.g60cca15819-goog


