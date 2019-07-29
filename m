Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC3478ED5
	for <lists+cgroups@lfdr.de>; Mon, 29 Jul 2019 17:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfG2PNy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Jul 2019 11:13:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35192 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfG2PNy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Jul 2019 11:13:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id s1so22117784pgr.2;
        Mon, 29 Jul 2019 08:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZnLXcFhj+Go8GG8/vsP0gGZ0JCfmJSZ7rbeDeF2qVeE=;
        b=XUK3INafO/K7rNvFDvDF8JVU+N+jADLF5S80ly0dl6c7dAg3Bn2NK4Xi3vS3+cBW6z
         k530Dav9ZNTwqZJ1gPbBE7huyQlh36P5Vt5+PcuZ+3tereumhe73oBeYjt1CandmYOwd
         csjOa6nhfGoWBtDgy7w/dzUn92301/n8eILgg62MHBX/MGo7k6jt7YTO+EnilKFCQ6S4
         pJvgnA1r2WpJzbU5JnudrG5cZ8fgRfu/22BfZiAonM2S0O9Y0ne4MrC1X7Arz7HUp/sr
         +2k/LOkqHrtganDCGLJRHHxYjM62wplT1spDMbekbbFIAQNKSCXVIhJ3xLzI8pJfJFrI
         LqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZnLXcFhj+Go8GG8/vsP0gGZ0JCfmJSZ7rbeDeF2qVeE=;
        b=cuBb1livmVKcFqWPnXLwopcrwggPF9m1jo3jHiF9l6VOZn1N2C/OC9c66cmbu0CzP4
         il95YY8v1ZUBcv0k1PIacqO6AhKbSh09O5B6XPjvcr4Scgxc6lyJkx1IGRFalRJ5h1ml
         rqodo8pxm+GsHyFoCxqxkOXVTecIS/QEGTT56DGxG9ViiCYw9q4kCHaF0lhclkGp7jLc
         TVPgzGzaNAcDsKNns9XM0QMlTew+3TswaFTCde4cUOn2I8mOd3El2QSE3VScx/8aoizD
         +Ov2W4QtYKJioqI21UAbx5f81sWK5H3TNdp3EQFPDAEPycHsEsXTvDiVcO3EVfKkrrtj
         pLXg==
X-Gm-Message-State: APjAAAVuFZrVEDLAKpaUBzUulk8edMkKlYHf1bk8m+neYPesx9VXGAtm
        /YKde2jG2PZkckebBzUtdeo=
X-Google-Smtp-Source: APXvYqzMajOUoR19pFuqbmPr8IgmUhfrMFA45ZK9qFI+NJaThzATOY9KVAMv5D52hHPcjJfWOhVCeQ==
X-Received: by 2002:a63:c009:: with SMTP id h9mr77405961pgg.166.1564413233854;
        Mon, 29 Jul 2019 08:13:53 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id q1sm72661765pfg.84.2019.07.29.08.13.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 08:13:53 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 01/12] rdmacg: Replace strncmp with str_has_prefix
Date:   Mon, 29 Jul 2019 23:13:46 +0800
Message-Id: <20190729151346.9280-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

strncmp(str, const, len) is error-prone.
We had better use newly introduced
str_has_prefix() instead of it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 kernel/cgroup/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/rdma.c b/kernel/cgroup/rdma.c
index ae042c347c64..fd12a227f8e4 100644
--- a/kernel/cgroup/rdma.c
+++ b/kernel/cgroup/rdma.c
@@ -379,7 +379,7 @@ static int parse_resource(char *c, int *intval)
 			return -EINVAL;
 		return i;
 	}
-	if (strncmp(value, RDMACG_MAX_STR, len) == 0) {
+	if (str_has_prefix(value, RDMACG_MAX_STR)) {
 		*intval = S32_MAX;
 		return i;
 	}
-- 
2.20.1

