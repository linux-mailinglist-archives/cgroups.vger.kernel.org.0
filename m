Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEB7FB530
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2019 17:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfKMQfF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Nov 2019 11:35:05 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40739 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfKMQfE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Nov 2019 11:35:04 -0500
Received: by mail-qk1-f196.google.com with SMTP id z16so2273178qkg.7;
        Wed, 13 Nov 2019 08:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xw70SBRGAaKGorTOjyeR6fitBzy2xSe0xSXfhKyCYgw=;
        b=kj0MzPKjmxb6LkA5WODTubivaZMgIS8X26k0mzw6XP2i9yAcO04LIN9rVGgnfQmd6/
         f9TaOH9Bf4CAOxWZjNlkJlSKJHIJtWIhZyhkTC9be9KPdifLHL6H/Z7SR0kmc+/fz4Mw
         gga/oVwgGWwO6D4OfREV7QKGHXfKeu0IqA4GP7+h7VF/bKhv3p8NB6gS5XbWF4e1wod8
         chadrZd0U5tDrlWH3PWu+UBlzxeeVZ1d9PHmrR3fW9Wae1erjTeS66w0U0kxGhj2kqln
         0GHonYrvpvuOr9yHqFfjd1MKb7WZZan/VB5u1SZNjqrr/LC9Vculiqq24sz9vT+IAyRG
         ckvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xw70SBRGAaKGorTOjyeR6fitBzy2xSe0xSXfhKyCYgw=;
        b=cTud0RQCwjpoWJKN14Ig2arfd+n520XrBv+JQA3l+E4H6QFPJimbRYNaJwO6b4h3/6
         FaKau37mg8omb8jbNVF3qRkXjD4pkHXsMZExmGS6q/2A4I9CQOB6VUlFGX+7dVoEKFKq
         gwQXurzLxdql3Dvu5YTYHYDt7oBaWYI2w8nYxj/ZaCAUIpQcmapZ/JG/vGVA1fMbYXbk
         nwU7MWUlVvIdSxSz89qtAmk2QHirLL+xsLqHCycS+B7QzBdblNGhYWeS75MAu1ZOwqlF
         rP662w4YShR76hctnqcTFCqLmZ0BjgIZ3xtKaUJeWnHd2c0EWHocF63w0Mnu0NEyAmyY
         07WQ==
X-Gm-Message-State: APjAAAVRJj5Vb7b6rC6XU0hQgcngqIca4BcSczItXQy0We++YTI+uS+1
        YYmk31S1LMEUpZ0PMaMkCV8=
X-Google-Smtp-Source: APXvYqykNYpe6UzqswVm0KftnXRPm84RMllxQFqx5nmhaks2To3+wsDwa4AeQmJxVovj1vsjhFyGWg==
X-Received: by 2002:ae9:c10c:: with SMTP id z12mr3241761qki.411.1573662903573;
        Wed, 13 Nov 2019 08:35:03 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:69f2])
        by smtp.gmail.com with ESMTPSA id x11sm1542637qtk.93.2019.11.13.08.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 08:35:02 -0800 (PST)
Date:   Wed, 13 Nov 2019 08:35:01 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        lizefan@huawei.com, hannes@cmpxchg.org, kernel-team@fb.com,
        Dan Schatzberg <dschatzberg@fb.com>, Daniel Xu <dlxu@fb.com>
Subject: Re: [PATCH 5/6] blk-cgroup: reimplement basic IO stats using cgroup
 rstat
Message-ID: <20191113163501.GI4163745@devbig004.ftw2.facebook.com>
References: <20191107191804.3735303-1-tj@kernel.org>
 <20191107191804.3735303-6-tj@kernel.org>
 <cd3ebcee-6819-a09b-aeba-de6817f32cde@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd3ebcee-6819-a09b-aeba-de6817f32cde@ti.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

Can you please see whether the following patch fixes the issue?

Thanks.

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 48a66738143d..19394c77ed99 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -626,7 +626,8 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 		bis->cur.ios[rwd]++;
 
 		u64_stats_update_end(&bis->sync);
-		cgroup_rstat_updated(blkg->blkcg->css.cgroup, cpu);
+		if (cgroup_subsys_on_dfl(io_cgrp_subsys))
+			cgroup_rstat_updated(blkg->blkcg->css.cgroup, cpu);
 		put_cpu();
 	}
 
