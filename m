Return-Path: <cgroups+bounces-5051-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D147F99312F
	for <lists+cgroups@lfdr.de>; Mon,  7 Oct 2024 17:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1AA1F231CF
	for <lists+cgroups@lfdr.de>; Mon,  7 Oct 2024 15:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF351DB95E;
	Mon,  7 Oct 2024 15:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlRX04vr"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FA11DB555;
	Mon,  7 Oct 2024 15:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314946; cv=none; b=f8bNzURNOy/dVtaVpXlWgJ7LG1ht51OEDxDavOaWySFdhltz/E8eh7pSrZ0DqrE3ZUIBTrjCh2ygmyveKWzC5wdd5x/e2hlfrapuZspl1t1OeWbLxJlPHVmwd2f6KnHfLVdwWqEwpUQO0iOv4S3Lg5NNAkehVBVywp2QcwDGKTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314946; c=relaxed/simple;
	bh=lAFXFSmVQdntEsKGiZXrEtWfDysFXzmsqFsCELUq0l8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iRWarEg+FaB1Qy+JhTl7p6oPwWPyiJsDptUz9V4DNh3nRXuoIAwTNMguCYYIL+jeykb+qEl0OHD7NhGgMwa2KwexPDqNDjvu7ijSTj4oNvdHhwRY4zxGTDFOmelxY7TW9rb1Ka01/C3k5oxZrfnVpBpHNPzQw1XXTBSp+utKOu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlRX04vr; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71def18fe1cso1674016b3a.0;
        Mon, 07 Oct 2024 08:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728314944; x=1728919744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzLZEFlScs6iq6xva3+0NW6bF6ERo7epGwi/efUM6jE=;
        b=TlRX04vrt2JDmaaQYQRnOBF7mk8qQrNbBE+q3gk2r9NPx3nuaQnXIbbI302FP8srhS
         7jgjzRQ3k/N+oPKcPTUNDLeRfVqBx/toTFNiLFoFyOAWxzFJNbMAz271hyPB0p0ODWDg
         UIjdQ1aoJSJi51OeOB/CdgDfs6NLkb8ZZuR62TlEK32gqqZxpkmcaa1kVPUTv2SBnMGd
         ABiQdQtBZjfrcQUtjT4YOwNy+/Ou7IqpJFha6JsncTQ4kdGJ3GLT+/6gppFSQHlQwPkw
         ZJvqmxYt1Ivmi3zXe3zhByvexPIFHteaEtDCOPb1pJbpI+fEsWcOxc2WQZ3RXcTdwMF8
         rgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728314944; x=1728919744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzLZEFlScs6iq6xva3+0NW6bF6ERo7epGwi/efUM6jE=;
        b=XPCWNgvmYFGhy9R1uo0fI2KtCtAmxRw0L8FluXnCKyX2eQ3nQgzrLDDNtw2KMMMIwF
         MuTVo9O9hvUl0M6aqoq/zQ0fCsvbOegQC8J0qmfxTWqIwrClk4H6cmocK7kXl9/APDHg
         gSkj7f4ZCTtcsd4BFKMjQLMzL43edrVgFwKcOFBZzqiAHEZ7r7jsbH3jE5fESG+muPZN
         w7n6Lb6M3c+ModkqIaB3EZRdSmLjV4CyCx16JxEx2ihwn9IKN/9L7w6M10HOdmXyepzY
         rgflrZDRKfZm2yXBcgunDUuFc5MuCt/IeSEUEr0i+/9SZhhLIXhWqzJu4OqwFzeaPvmm
         t0hg==
X-Forwarded-Encrypted: i=1; AJvYcCVC3F1ivrAbqrrlx5aDRQ3zZo1LcHrOryzwGjHLz5dtHtmF+Mh60+0Z1t1yeK6VldpP6gJ41VNN@vger.kernel.org, AJvYcCWw8pvSZKlEqWgOX79ErCaFO78IHHbxyMool7dctrUYmT26i91XTYkYGDYhTDOe0eQIwOiS2OI0v6Yx9jy4@vger.kernel.org
X-Gm-Message-State: AOJu0YyScVL8UA0Ewr18iZB5mXJ2BU98DB5sdj6lRSxqruFpeqtraEdO
	Vw1MgKFxSPg+zfv79cVlnB4szXU1IO/8PK71dNXFoj51+NpqFOh+
X-Google-Smtp-Source: AGHT+IFmaJYCgfcqvpx9xMLTLS2Sq4+nITc7aHu4JzeIwZmZ/djVHsSyztw51ABu/SMp/FED+S4UpQ==
X-Received: by 2002:a05:6a00:2286:b0:719:8f48:ff01 with SMTP id d2e1a72fcca58-71de239d691mr20702748b3a.6.1728314944374;
        Mon, 07 Oct 2024 08:29:04 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c4adeasm4360337a12.84.2024.10.07.08.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:29:03 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: xavier_qy@163.com,
	longman@redhat.com,
	lizefan.x@bytedance.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	akpm@linux-foundation.org
Cc: jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 6/6] MAINTAINERS: Add Kuan-Wei as co-maintainer for union-find
Date: Mon,  7 Oct 2024 23:28:33 +0800
Message-Id: <20241007152833.2282199-7-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007152833.2282199-1-visitorckw@gmail.com>
References: <20241007152833.2282199-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm happy to help maintain and review patches for the union-find data
structure. Add myself as a union-find maintainer.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e503802c1549..c3b1a5641765 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23795,6 +23795,7 @@ F:	include/uapi/linux/cdrom.h
 
 UNION-FIND
 M:	Xavier <xavier_qy@163.com>
+M:	Kuan-Wei Chiu <visitorckw@gmail.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/core-api/union_find.rst
-- 
2.34.1


