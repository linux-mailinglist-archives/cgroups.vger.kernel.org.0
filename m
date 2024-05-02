Return-Path: <cgroups+bounces-2751-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9BC8BA0C2
	for <lists+cgroups@lfdr.de>; Thu,  2 May 2024 20:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58A90281507
	for <lists+cgroups@lfdr.de>; Thu,  2 May 2024 18:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F82174EFA;
	Thu,  2 May 2024 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CT7I28iT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8B1FBF6;
	Thu,  2 May 2024 18:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714675992; cv=none; b=eZ59Y8nec1wQv5daNZwlwf1BvS1FHjOf0yTc/igvUz1LDvwncX973izBfcWeaMQmBQCgx4Y2maZutvxj/7n/5Qc6kVNjDTGZ8B6ll2sCkEYLxvmPg1cPy4LK3qUNd2UXoSMqRgyOjcJFF6i+gXA3TaMngSpuvcBi4pqxxABdCFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714675992; c=relaxed/simple;
	bh=reLSScNRkTb7ZPg2+d2RPvAhGkTXng+CyawqE4WCe94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f38VzqefHeeZgHwtc8r1Mn62Evqb2BkZEjyhb2EHGBL13dITKWaG/UYxIRhAP6pfFiYiPBa1f0LYrkPsBSq+nx/fuIfumfVf2XYR3u9oWFSa/YUnLJ8XFpAvjoNlnbqamrqs015WTGMARS3MkBVUH49MZJVc7vKYAhfgw68KElQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CT7I28iT; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-de596c078c2so8364874276.0;
        Thu, 02 May 2024 11:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714675990; x=1715280790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CSWP88mOlQbRGt3UYtKXNEBcnsEYRh/LG/ZPKW4PivE=;
        b=CT7I28iTPPzWgXmOJIvpf74giF6k0S9hn/nse4b68inK1C2C4ZpNJ+qK0h7lV0PkZW
         EdfKLf7eVghIxEVkyJIntpy5Ety1xDd+lBORiggYe8CHC/N4wJj12on6KWRLo1vm9h86
         u5TG/6Rip/5H4jP/7mE1cqI1txrdrPUmwj+ttHcGXfI3E9s6bIF2WG1O9U7jobB8Q9DY
         6gvplFKmn9jHPXbikcsC4Cy5bHsDgRVWL0PkMwC/zxIvV6qgWrWnOM0GRLfUeJ0WwjS9
         OtjtYP8K81Z5Z/zyGXHXy+roNy/dOpgD6QrJ23/84Y9eFzkBnGQXYbpifEJfgNpBKYQP
         HG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714675990; x=1715280790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CSWP88mOlQbRGt3UYtKXNEBcnsEYRh/LG/ZPKW4PivE=;
        b=oKlKDA51hwDKDIaUREOofK5ol8D5PhViTbXYxQhoNVg0ZEdDIsWf85ifITnqw9J12L
         vMRBUQ8VAWGH9AgC/0CYx8I1Yc0CsCCb+p6Yh1nr53Y6QU9+K4p/fM7NoKDtzG46Ker3
         EL6S7vShKly3tslqaBTNkS9vpCoD1LbJzIU6lmqCYO8OjK6upOM/V3bFqBuT5hKmFXOV
         dxWkUNT6yyOx9IThKd9PtIKW84sa1mqhH/H+kIwHHet9M5hL56t/kByJZ3WpcaFGUUCO
         vOpfgb09gSx4jjVB8Gzc5KTOBfw8hWTu3oe8TNDmO+DxNcGvXNSqaUEq10CFFPwX3l2N
         wjyA==
X-Forwarded-Encrypted: i=1; AJvYcCXzEI6N24zVSslpgZJHyBZcpfqIzIKbepjAwgwbF94FX21VdLKsrdb1eiiOpPfZdQzw4hNzkix+z5EyjiNETLi7kwtnnfB2Bs/aUtiohPS2Sshcm6F3Lo1pyMJ80O8iukrKc4hoxkRmVd3J0ULl1t9IZHiY9Jbsv5wc6DyEaetDcA==
X-Gm-Message-State: AOJu0Yw6HDJZGIVn6+LmZHUMdPwQNtznkIVuRsd6X0aJwFkwMKmXY+0t
	+m1sT6oh2OGm7dsrR3UHN6gLqf9ajF22hNZkor5cdAstKKWbPCHB
X-Google-Smtp-Source: AGHT+IHuyijo6sXZ6QSoIbtOFsuIU0dKx2liVY5AiWbWg2L0PHrHYzreL9sVqKWz3I7v4JloP3EQHg==
X-Received: by 2002:a25:a4e5:0:b0:de5:f583:2b17 with SMTP id g92-20020a25a4e5000000b00de5f5832b17mr882387ybi.9.1714675990482;
        Thu, 02 May 2024 11:53:10 -0700 (PDT)
Received: from localhost (fwdproxy-nao-007.fbsv.net. [2a03:2880:23ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id fz18-20020a05622a5a9200b00439a9319a4fsm724753qtb.48.2024.05.02.11.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 11:53:10 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: hannes@cmpxchg.org,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	nphamcs@gmail.com,
	corbet@lwn.net
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v2 0/1] cgroup: Add documentation for missing zswap memory.stat
Date: Thu,  2 May 2024 19:50:23 +0100
Message-ID: <20240502185307.3942173-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This includes zswpin, zswpout and zswpwb.

v1 -> v2:
- Move doc location according to output ordering in
  memory.stat (Johannes Weiner)

Usama Arif (1):
  cgroup: Add documentation for missing zswap memory.stat

 Documentation/admin-guide/cgroup-v2.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
2.43.0


