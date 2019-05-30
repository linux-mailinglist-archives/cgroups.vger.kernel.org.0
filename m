Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61BED3020E
	for <lists+cgroups@lfdr.de>; Thu, 30 May 2019 20:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfE3Sit (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 May 2019 14:38:49 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37398 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfE3Sit (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 May 2019 14:38:49 -0400
Received: by mail-qt1-f194.google.com with SMTP id y57so8264803qtk.4
        for <cgroups@vger.kernel.org>; Thu, 30 May 2019 11:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TlPyZ6uzeyfBDu8YbILXzbg9oBHfiZooCGJrdxrmQwQ=;
        b=D7Too+/aQWPlUAKn58KmTHvszQ1N9tRLYDpUJ8MY5GFu23D8J17/C2toGby417xEom
         c2sMPYcj+Z6e1JfWTUZxNzT+r+P1DI1IRdr5DxC78Vabd0Y+jFA16um5+e5A0OgYsgsO
         XjB/kkpLiwMXwZZlXNeuy1gpbnOWp+rcQJORG0qZPBxPuXydLPw/O2+6//0FAHY598/w
         9fMbvXaHrjRItch2KQnPHr223Q1uoLYxDSPYzk7oVcKMPIdq2dEGKTIeu40Rr2tkWgQZ
         ONd6oUHpONF5tCS6I8ohWCCHYFw7BYphwvZoi0VuiOeG7MvUcUn9VBH8bU7+DaRtEkeR
         Oxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TlPyZ6uzeyfBDu8YbILXzbg9oBHfiZooCGJrdxrmQwQ=;
        b=diMoAPw7R/cCBz6lr5A74iUC9zkgKA+RQYW5wXcZWLN6l0uj9zabTCdkq0p8lWG4dz
         /ZJBdktSpqNpUnkGrXa2qkWCQZpCOaEOB4ku2/F5OAYpgQHNk8AXaII65aLH7X1HQ2Zw
         vV1XpH0eAP6f/rzcdMnRN+O3lRKMPcBqLj3Bnmch9Ab36pmo4znbNagG1VhYwPgxiFJY
         K5VOb9Drdz+Bc/4bD5zksEOh+880kc8UBYtnj7rF3u4G1rbAS4DP+07FjlP45gkbPK9J
         h+t3u1TP/5z8Q5cnhjiaIzQJKfL+NTha6A+i45ZI6O/ZkXix87wRA9Ctyw6q8rBzppgr
         I+Uw==
X-Gm-Message-State: APjAAAVAu0wcvqf913/9b4Ytu0INs/1fpyuU1DokCwIcEru9Xaq5IVap
        EF+MXOJ46UG6PnZHk4rSKJc=
X-Google-Smtp-Source: APXvYqwpQlZp2T2e1iGO6tqTAkBzBAFa2SDbZNcXTIQaBzGBt/quNavSQA4GQUoDovKUvScmbDIM8Q==
X-Received: by 2002:ac8:674a:: with SMTP id n10mr4996483qtp.307.1559241528130;
        Thu, 30 May 2019 11:38:48 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:658d])
        by smtp.gmail.com with ESMTPSA id y129sm1899138qkc.63.2019.05.30.11.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 11:38:46 -0700 (PDT)
Date:   Thu, 30 May 2019 11:38:45 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Li Zefan <lizefan@huawei.com>, Topi Miettinen <toiwoton@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, security@debian.org,
        Lennart Poettering <lennart@poettering.net>,
        security@kernel.org
Subject: Re: [PATCH 3/3 cgroup/for-5.2-fixes] cgroup: Include dying leaders
 with live threads in PROCS iterations
Message-ID: <20190530183845.GU374014@devbig004.ftw2.facebook.com>
References: <20190527151806.GC8961@redhat.com>
 <87blznagrl.fsf@xmission.com>
 <1956727d-1ee8-92af-1e00-66ae4921b075@gmail.com>
 <87zhn6923n.fsf@xmission.com>
 <e407a8e7-7780-f08f-320a-a0f2c954d253@gmail.com>
 <20190529003601.GN374014@devbig004.ftw2.facebook.com>
 <e45d974b-5eff-f781-291f-ddf5e9679e4c@gmail.com>
 <20190530183556.GR374014@devbig004.ftw2.facebook.com>
 <20190530183637.GS374014@devbig004.ftw2.facebook.com>
 <20190530183700.GT374014@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530183700.GT374014@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

If there are no objections, I'll apply them to cgroup/for-5.2-fixes in
a couple days.  Tagging them -stable makes sense but the changes are a
bit tricky so I wanna wait a bit before doing that.

Thanks.

-- 
tejun
