Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB3F98B61
	for <lists+cgroups@lfdr.de>; Thu, 22 Aug 2019 08:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbfHVG27 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Aug 2019 02:28:59 -0400
Received: from mx6.ucr.edu ([138.23.62.71]:32037 "EHLO mx6.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728405AbfHVG27 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 22 Aug 2019 02:28:59 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Aug 2019 02:28:58 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1566455339; x=1597991339;
  h=from:to:cc:subject:date:message-id;
  bh=te6sDAmETT+7Bh5fmhANTjsc/hBDg1ooMbPzRFeOAW8=;
  b=ONMl2yicsEZYX1VeXYnCnlf3FCRgigF2jm/aKBLNoqkEOatd2uWvIVB1
   Xix1KUAtDRKcLqiK4Jc3iO3woAFVxnmdXNB62LTDF9S5KMIOvgWD19Xs+
   8RIB1wvHNzSnbEOmtzJGRYYP95z88MZzbwwX60Hhgmo8NkMppMtdwcRqm
   Xhne9svEWMcKhc5c5IF51kK6DFliVgHxuEU8E7gIKqNrpmCzMqC/C4Eux
   w7WcmCSIHt8fiD5JsKgn3y/+B+0Kz+ZOjxEDr4XPaPd9UFlDj4bWM0VMY
   s+zwfen0Lt9vG41P/WNOc+zTO+0qkhxzVXb/kVoiGqGUqmWeakdjs7Mt5
   A==;
IronPort-SDR: vLPhze5RQ53aQGyRfDRnCQWCmkzjn7pbH6w8z+yWwEsIERqrlALQ6ImS9cU0BV9GI7tf7K/HBy
 bvvfgyQZm/zTZMJisbo8zfEpa17z/3OO00tLmrfRzzV9uDlyC6sltiddIhUrB/ffjgL/7sr2w5
 JOXMXN/AOX245F3khm4gQRDk++BUoIeioNHHrRQfzj1gQ84OswDwgdIY7h4HypeCpn29THYDCU
 LDwIQ3++lvyigAnvIhgp/ls+LDCVBe4lgfIN0/aQkTZBJ5J6Y0ojAgUtJQ2mwWUavPEf4QQ1Bh
 edU=
IronPort-PHdr: =?us-ascii?q?9a23=3AMEmM6BzVCPOFYvrXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd1OIRIJqq85mqBkHD//Il1AaPAdyBrasY16GP6/CocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmSSxbalvIBi5ogjdudQajZdhJ60s1h?=
 =?us-ascii?q?bHv3xEdvhMy2h1P1yThRH85smx/J5n7Stdvu8q+tBDX6vnYak2VKRUAzs6PW?=
 =?us-ascii?q?874s3rrgTDQhCU5nQASGUWkwFHDBbD4RrnQ5r+qCr6tu562CmHIc37SK0/VD?=
 =?us-ascii?q?q+46t3ThLjlTwKPCAl/m7JlsNwjbpboBO/qBx5347Ue5yeOP5ncq/AYd8WWW?=
 =?us-ascii?q?9NU8BUVyxAGYO8dIoPD+wOPe1FsYfzvkYFrRW/BQayAOPg1yJDinv40KEm1u?=
 =?us-ascii?q?gsFxzN0g49ENIUqHnarMv7OrocX+62y6fF1inPY+9M1Dvh8oXEbgwtrPeRVr?=
 =?us-ascii?q?xwa8rRzkwvGhvHgVWRqI3lPy6V1uMQuGWc7+thVOKvhHQmqw1tvjSiyNwhip?=
 =?us-ascii?q?TViYIP0FzL6zh2wJssKNC+VUV1YsakHYNOuy2GM4Z6WMAvTmFytCok17ELto?=
 =?us-ascii?q?S3cDUOxZkl3xLTdv2KfoyS7h79WuucIS10iGxkdb6lhRu//k6twfDmWMauyl?=
 =?us-ascii?q?ZFtC9Fn8HJtnAKyhPc9NCKSuB4/ke9wTaP0B3T6v1cLUA0i6XbL5khz6Y1lp?=
 =?us-ascii?q?UJsETDGjb6mF3yjKOLb0kk9PWk5uDlb7n8qZ+cMIh0ig76MqswgMCwHeM4Mg?=
 =?us-ascii?q?0WU2ia/+SzyqHj8FXnTLlWivA6iKrUvZDAKcgFu6K0DBVZ3psn5hu9Fzum1c?=
 =?us-ascii?q?4XnXgDLFJLYhKHiI3pNknOIfH5DfewmVWsnCt3y/3IJbDhH4nCLmLZnLj/YL?=
 =?us-ascii?q?l99lZQyBAvwtBH+5JUFrYBLervVU/+rtzYCQI5MxSvw+v8FtV92Z0RWXiVDq?=
 =?us-ascii?q?+aLqzSq1mI6fwrI+WWY48Vojn9eLAL/fnr2E44i18AeuH9zIkXYXHgRq9OPk?=
 =?us-ascii?q?6DJ3fgn4FSQi8xogMiQbmy2xW5WjlJaiP3APox?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GYAAAFNF5dgMXWVdFlHgEGBwaBVAg?=
 =?us-ascii?q?LAYNWTBCNHIZTAQEBBosdGHGFeIMIhSOBewEIAQEBDAEBLQIBAYQ/gmAjNQg?=
 =?us-ascii?q?OAgUBAQUBAQEBAQYEAQECEAEBCQ0JCCeFPII6KYJgCxYVUoEVAQUBNSI5gkc?=
 =?us-ascii?q?BgXYUBZxhgQM8jCMziHgBCAyBSQkBCIEihxWEWYEQgQeBEYNQhA2DVoJEBIE?=
 =?us-ascii?q?uAQEBlDSVbwEGAgGCCxSBb5I+J4QsiRSLBwEtpTwCCgcGDyGBMQKCDU0lgWw?=
 =?us-ascii?q?KgUSCeo4tHzOBCIkOglIB?=
X-IPAS-Result: =?us-ascii?q?A2GYAAAFNF5dgMXWVdFlHgEGBwaBVAgLAYNWTBCNHIZTA?=
 =?us-ascii?q?QEBBosdGHGFeIMIhSOBewEIAQEBDAEBLQIBAYQ/gmAjNQgOAgUBAQUBAQEBA?=
 =?us-ascii?q?QYEAQECEAEBCQ0JCCeFPII6KYJgCxYVUoEVAQUBNSI5gkcBgXYUBZxhgQM8j?=
 =?us-ascii?q?CMziHgBCAyBSQkBCIEihxWEWYEQgQeBEYNQhA2DVoJEBIEuAQEBlDSVbwEGA?=
 =?us-ascii?q?gGCCxSBb5I+J4QsiRSLBwEtpTwCCgcGDyGBMQKCDU0lgWwKgUSCeo4tHzOBC?=
 =?us-ascii?q?IkOglIB?=
X-IronPort-AV: E=Sophos;i="5.64,415,1559545200"; 
   d="scan'208";a="71805032"
Received: from mail-pl1-f197.google.com ([209.85.214.197])
  by smtpmx6.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 23:21:51 -0700
Received: by mail-pl1-f197.google.com with SMTP id s13so3019326plp.7
        for <cgroups@vger.kernel.org>; Wed, 21 Aug 2019 23:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8jiYykEIKY+vErKJnS6hI8dD2/3tnco1PA9iNXuAOYk=;
        b=F1C7DP0eDL+mLyVPr3k2c0b4QEk/E5EcLht7Ru8cPa3uxncZV6IMgC2iDVTb0ekOw2
         YFuJNLea9kTrmMP4QBuK7ZXSkgVVByCreBr7eV4fOvL5bYL2lJgyLKtmlSHgjS5BKm5C
         PJQc+LEACvyDSmZud/Vfw0ikauK33vbOtyPjxPfhiIdd81+0X6IUVBPLTsztimTofdoy
         4PuhxkkoNZEEU193GtIQ4UsFK0HrYB55lZaRY+ZIy0qG2Cx3touNOwf0sIBIEtlNx6Hq
         P6w3T42NeR20pq5LF4vqXpl4qCVCDQL6UlzYkEeFUzLAPDPKYLAMj8LKLBMC4rQtsL5b
         0nDw==
X-Gm-Message-State: APjAAAV6yRTWw8p4muEmi7jVM/W1jsnFYETtHr/x5OcH7QHwDD55sFiZ
        tuvFtPhKRBOGH7imeLLn7su4d5o9Zd/5ClcYZtdx/ZjUjeYtXrlji6kiqAP/OtI6QzOhTwmHRru
        8P+VeOxDr1HMeT/SAN/g=
X-Received: by 2002:a17:90a:4c:: with SMTP id 12mr3675060pjb.40.1566454910365;
        Wed, 21 Aug 2019 23:21:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxPagb0bDHT1I4Z/sKRwM+ZNsKDqjx+3do3M12tj3N4RR0xguVlX5L/h68YeOUt+IBeLNfJ5g==
X-Received: by 2002:a17:90a:4c:: with SMTP id 12mr3675033pjb.40.1566454910065;
        Wed, 21 Aug 2019 23:21:50 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id b123sm44863606pfg.64.2019.08.21.23.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 23:21:49 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/memcg: return value of the function mem_cgroup_from_css() is not checked
Date:   Wed, 21 Aug 2019 23:22:09 -0700
Message-Id: <20190822062210.18649-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Inside function mem_cgroup_wb_domain(), the pointer memcg
could be NULL via mem_cgroup_from_css(). However, this pointer is
not checked and directly dereferenced in the if statement,
which is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 661f046ad318..bd84bdaed3b0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3665,7 +3665,7 @@ struct wb_domain *mem_cgroup_wb_domain(struct bdi_writeback *wb)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
 
-	if (!memcg->css.parent)
+	if (!memcg || !memcg->css.parent)
 		return NULL;
 
 	return &memcg->cgwb_domain;
-- 
2.17.1

