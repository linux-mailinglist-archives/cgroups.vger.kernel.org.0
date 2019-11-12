Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC17BF9450
	for <lists+cgroups@lfdr.de>; Tue, 12 Nov 2019 16:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfKLPcG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Nov 2019 10:32:06 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43216 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfKLPcG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Nov 2019 10:32:06 -0500
Received: by mail-qk1-f195.google.com with SMTP id z23so14749769qkj.10;
        Tue, 12 Nov 2019 07:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=txi8K03pLThFDkWsT6CYgC3qWrtDI9yq4KLSf5kI69E=;
        b=ASwpDsxCBMRtKw22jZ1x0MOo0TIreehZJpszCtZRw7FCZXiovUXWbmnztbYCxD2puO
         U0O9v39aj0qUTlBvwM6kyWLU462Z1RrdDQVkkUEVTT8zkEvaeLTYz3KnbPNNEXI3bDcE
         /Cccu8IW3+h090ZtUpepxN2vq4GdfN3UwVb/IALwzEBmhPhU6nXTi7e3PS9zA4qX8g/H
         naqFo8NaR0cv9OG436dGEX4kF4+n2Y7iRfeonT50wVaenI8zIlfarqLoKdFSO0YjHrY2
         wGzRlD9/psHV0KD06MUeeW3eZrW/JTldPmOiGW6G5UbwCNq+V98zRxIZ9kbWuw4NiKT1
         IndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=txi8K03pLThFDkWsT6CYgC3qWrtDI9yq4KLSf5kI69E=;
        b=my/egWLpXcO9Nr4a0lEEum1D4bJME0XXzLZdpjnYOWRfBS6weg1/7a3RI9dGV2NohY
         XFk6nowqfr9/ZaALHCP8rZaSvCUHCx/i7GI02W15k7iLsVXYk59gLchpGCotzKlNd5xG
         xjLP6YlRlDKfdptjcaxs8lUH5Hw0vZ4r3my+I+8qeoEQVYCpM46Qc6HsmWDxqahRxaMJ
         7C46CiKrSxKJNQtoSx2cVN+oU7oqR8HSmZZ9W5gLtaZL+O36+jw4KMVvLxGPvDkr9iIO
         Gc1ipv58Qw4+lKbbT5ALRNQDyvmWSjMcmXK7qjIJw70IIPzUE8fa/NRDF2xRybWJvU5x
         ppqA==
X-Gm-Message-State: APjAAAVmFZ3/V5hZM9IM64+GIb+eW7e8L6jB3EVzTbmMNElR2FWLOpnp
        8+jQ2T8SaM0o3eqyM1jTQI+QrK19
X-Google-Smtp-Source: APXvYqxlXxejv6YrIuk99ddPzOpwBuB0RFNlNxNFTbpmXdZN6+Mj5W57IR9cGDah8x82Ol4s/NYDyA==
X-Received: by 2002:ae9:e810:: with SMTP id a16mr15039988qkg.261.1573572723322;
        Tue, 12 Nov 2019 07:32:03 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:f36a])
        by smtp.gmail.com with ESMTPSA id s21sm11489497qtc.12.2019.11.12.07.32.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 07:32:02 -0800 (PST)
Date:   Tue, 12 Nov 2019 07:31:59 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Jiufei Xue <jiufei.xue@linux.alibaba.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH] iocost: treat as root level when parents are activated
Message-ID: <20191112153159.GD4163745@devbig004.ftw2.facebook.com>
References: <1573457838-121361-1-git-send-email-jiufei.xue@linux.alibaba.com>
 <20191111162538.GB4163745@devbig004.ftw2.facebook.com>
 <7be6fb71-7e08-e369-cbbe-678129cc62ff@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7be6fb71-7e08-e369-cbbe-678129cc62ff@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Nov 12, 2019 at 09:38:57AM +0800, Jiufei Xue wrote:
> > Hmm... I'm not sure this description makes sense.
> > 
> Should I change the description to something like this?
> "we should treat the leaf nodes as root while the parent are already activated".

Hmm... this is addressing an obvious bug.  The intention of the code
was checking whether all the ancestors and self have already been
activated but it just failed to do so, so I think the patch
description should reflect that.

> > But there's an obvious bug there as it's checking the same active_list
> > over and over again.  Shouldn't it be sth like the following instead?
> > 
> > 	if (!list_empty(&iocg->active_list))
> > 		goto succeed_unlock;
> 
> iocg has already checked before, do you mean we should check it again
> after ioc->lock?

Yes, that part of the code is correct.  It needs to check it again as
someone could have changed it since the previous lockless
opportunistic checking.

Thanks.

-- 
tejun
