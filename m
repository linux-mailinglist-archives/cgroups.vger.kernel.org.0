Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34059123060
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2019 16:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbfLQPcQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Dec 2019 10:32:16 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51250 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbfLQPcQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Dec 2019 10:32:16 -0500
Received: by mail-wm1-f67.google.com with SMTP id d73so3365585wmd.1
        for <cgroups@vger.kernel.org>; Tue, 17 Dec 2019 07:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jr1dFn2z1P4MsCtmqPO29rPINYbqBsWbvl95K0lo3qY=;
        b=S8MaiI4Z66kRaGiMhNUN5izJT/aLZ2SBTEoB/9/RfJGT+OLbgVeTb6CrjMk2gwEaEM
         iApa7Msqy8sCczZO6v7wBKLtLk0o2ps7CXJQeGl93tTlLgTx8zPCahSxnVSmPwoBo6gP
         QBL1DbYqpLBffIsBuRFiZz/01B9trZgNwndZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jr1dFn2z1P4MsCtmqPO29rPINYbqBsWbvl95K0lo3qY=;
        b=tjmGRdZW/9P5KWnsxEcHcoLbVwd0Z9qxzmVhjLDnCEUbXYA+v9tcC8VzNO/NiFH/8o
         EbmGrgpVV3oqNnceq1AL5QQFNUK4IEIw91g20SejSl4sDUY58khzsE20t74tqSh5QLyB
         w1F657ABKkqPnTKWeLLGITcLM/zqB2ENkbsE8yJkne15rkO8XoIwpl13qDeXRrBee6Be
         lwc6vV+88RCHadZ90IKbzkGn8233coT8boMkjWpXu07ziRR+bjEDaNxibLKLsdj733Cd
         LmGF4tbyE4L+1DQIqXCYPsfbB57HRMdLJ59zFtZOZsjb5mTDzb/xTKxMLtiKd3nHbdht
         opUg==
X-Gm-Message-State: APjAAAVIqB9JQuTjH1aQjiJe1hHzeDOrwurpEwgbj6bBxc0R7sWvjMiW
        pdKZwiJMZikSL1v+lj9nfaJuNQ==
X-Google-Smtp-Source: APXvYqzjU+JjhEXh9jQai0fkom/Xh8F1LV3x9ndI4wUqXHm32YZsa8QsrQNMx4xEzc2db+PVzyZe/Q==
X-Received: by 2002:a1c:1bc3:: with SMTP id b186mr6133038wmb.79.1576596734150;
        Tue, 17 Dec 2019 07:32:14 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:f184])
        by smtp.gmail.com with ESMTPSA id f9sm3320285wmb.4.2019.12.17.07.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:32:13 -0800 (PST)
Date:   Tue, 17 Dec 2019 15:32:13 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Qian Cai <cai@lca.pw>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol.c: move mem_cgroup_id_get_many under
 CONFIG_MMU
Message-ID: <20191217153213.GC136178@chrisdown.name>
References: <20191217135440.GB58496@chrisdown.name>
 <392D7C59-5538-4A9B-8974-DB0B64880C2C@lca.pw>
 <20191217144652.GA7272@dhcp22.suse.cz>
 <20191217150921.GA136178@chrisdown.name>
 <20191217151931.GD7272@dhcp22.suse.cz>
 <20191217152814.GB136178@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191217152814.GB136178@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Chris Down writes:
>Maybe Qian is right and we should just ignore such patches, but I 
>think that comes with its own risks that we will alienate perfectly 
>well intentioned new contributors to mm without them having any idea 
>why we did that.

s/Qian/Cai/ :-)
