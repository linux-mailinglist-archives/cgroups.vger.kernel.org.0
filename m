Return-Path: <cgroups+bounces-2928-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE438C7708
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2024 15:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B1F5B21B79
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2024 13:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABCF146D5A;
	Thu, 16 May 2024 13:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jP478jQ7"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68B11465B7
	for <cgroups@vger.kernel.org>; Thu, 16 May 2024 13:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715864655; cv=none; b=Qe46RGboh/yCUKTctMT8ulP7XJMd/feT5MqczhsAbEyePd42gAv+cKpGYCLmpr7TF//Aq5iqlhDXM3svlyDGzjWwzPXZNexkI3tpaYlbuBOxV0B5S2BSJHhQZfx6rsfJRSb/NYz6qAqBrmNFcpVsH/kv5wD9cEu7fYlzjq5UWY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715864655; c=relaxed/simple;
	bh=CYbU+iTKUs++kZfDgFdZa6ah0eEMidjuFp5veKjhXXE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=DpXGF00yEkRSudX9mel5TjtB+PHYaZhIMdReRENs+4sI82WlMW1qNfO0YloXHUiu/NwOYQ4rV3yjGlWhIhE9nApxmiGU1ZOiTwxKqFe8O/E3ndI+tI+tpbZf4wx28wZsgC9MttKNBp8lQZ60N7bxgZbHXv1EYYUxd3F1NSC2rmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jP478jQ7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715864652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=fMhujxl7GYzS5ei+Ia3VImv29dSe1TrNNjtJn8rOB2k=;
	b=jP478jQ7poR8Hoqz0vTS89kRUspB9j7AdxC8Pe83gcCI74zbhQmKpSdjmJ15JsgG0Beh5I
	974dm6D1CqSwfWoB1vx3vAHKa5HNq9OsOFk6Uzxf4rgN0xNLapVJ8o2Xxjn1nIcYx8mAka
	ztPY+SJWY/HvCfZOIuWv6RvFpFB07IQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-6qhSDOKvPpeqQdIXGIZ2Xw-1; Thu, 16 May 2024 09:04:10 -0400
X-MC-Unique: 6qhSDOKvPpeqQdIXGIZ2Xw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2b38e234a96so7128842a91.0
        for <cgroups@vger.kernel.org>; Thu, 16 May 2024 06:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715864649; x=1716469449;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fMhujxl7GYzS5ei+Ia3VImv29dSe1TrNNjtJn8rOB2k=;
        b=EHwfsIAytX62FPVtGRHReN9Sa+aHHrPBU6VxYuScrkVjq89qdsxohJ+xRLJPY0wIgO
         B2BEKaZZxin3ofDk9+PxdC2XuyT87c+faCp4+pbCFoGIJXN3Qb+yI0Qy4p7j6dCsO71u
         4XA/JlYgCw3oO1ugJ0smnsQ3skXIHzL2P+4im8c2Fe0PuAzPNYT+Y4Hzx7vHXd2/9MAt
         oVT//jwvgJl4L0Re3O5hYJbE+7vK4+6geyyoiHRhO+OOrxfSyCjRbU3AkCm2QmJXin/v
         e95vaLjZxNyKwcDe/YBG+G4VeGDgk7Rvim27553CuNP0LCzMg32LAb+tmlhxmgUVInez
         avhA==
X-Gm-Message-State: AOJu0YxqHvFkgsYayplGC3HCew2VVNta+I12VXHlg7wta92G2arRsPbz
	MhuSpUJfI2C/nAKwPDmHgaO7OOrJV+8HW9JbFhQf2Bkz2Q56BO1N2KIg/JNkk72IumE/w79s7oE
	nRfUvOpWVvEYeFhVP/QfL/0jUzScU+aqhNB7Zy7q9//AiLYepHdaAu93dQTSf7Hny5+r7pc70aY
	tLJTljyPs7b6N0PPS8nDPmRWwWSEpqZR/HVAT7LvbZ3u8=
X-Received: by 2002:a17:90b:23c4:b0:2b6:2067:df12 with SMTP id 98e67ed59e1d1-2b6cc757e72mr16265715a91.16.1715864648544;
        Thu, 16 May 2024 06:04:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiXJ8xzaM+sGR9V2lV9ZYnwsi82g3pfuFe+KOmIVZ/MQ0t7sgQYbKUSt4txmsqKtwZn4QVaIRfEY2ITS8mcTM=
X-Received: by 2002:a17:90b:23c4:b0:2b6:2067:df12 with SMTP id
 98e67ed59e1d1-2b6cc757e72mr16265696a91.16.1715864648073; Thu, 16 May 2024
 06:04:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Changhui Zhong <czhong@redhat.com>
Date: Thu, 16 May 2024 21:03:56 +0800
Message-ID: <CAGVVp+W4FdKU44aaoMbwcShEHZoHxg1NVe1EcLJHFQi62XL3mg@mail.gmail.com>
Subject: [bug report] leak blkio in cgroup
To: cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I hit this issue on recent upstream, looks there is a leak blkio in cgroup,
please help check it and let me know if you need any info/testing for
it, thanks.

repo:https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
branch:master
commit HEAD: 3c999d1ae3c75991902a1a7dad0cb62c2a3008b4

reproducer:
1. install podman and container-tools
2. # for i in $(seq 1000); do podman run --name=test --replace centos
/bin/echo 'running'; done >/dev/null
3. # while [ 1 ];do cat /proc/cgroups | grep -e subsys -e blkio |
column -t; sleep 5; done

results:
#subsys_name  hierarchy  num_cgroups  enabled
blkio         0          85           1
#subsys_name  hierarchy  num_cgroups  enabled
blkio         0          138          1
#subsys_name  hierarchy  num_cgroups  enabled
blkio         0          210          1
#subsys_name  hierarchy  num_cgroups  enabled
blkio         0          283          1
#subsys_name  hierarchy  num_cgroups  enabled
blkio         0          357          1
#subsys_name  hierarchy  num_cgroups  enabled
blkio         0          430          1
#subsys_name  hierarchy  num_cgroups  enabled
blkio         0          505          1
#subsys_name  hierarchy  num_cgroups  enabled
blkio         0          578          1
#subsys_name  hierarchy  num_cgroups  enabled
blkio         0          653          1
#subsys_name  hierarchy  num_cgroups  enabled
blkio         0          726          1

--
Best Regards,
     Changhui


