Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2524015DA60
	for <lists+cgroups@lfdr.de>; Fri, 14 Feb 2020 16:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbgBNPNY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Feb 2020 10:13:24 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37242 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgBNPNY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Feb 2020 10:13:24 -0500
Received: by mail-wm1-f66.google.com with SMTP id a6so11005563wme.2;
        Fri, 14 Feb 2020 07:13:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Do7bMdbDxyWMTf+bB896rP3/6/in5BnwlBFvOvluDwA=;
        b=tttIxo7ByX9RVYZNtcgJe1Eyw8TjI6YFQpC4xFLl9vTTRFmha+1nABfjyoblBfMr4V
         FKRK2nLD0f8MJFmcrDt4FTS05F+MnVYFNkkv9ae+JTFTUqkRD5Cm9IaaclQ59uYjC57I
         Ic0cjmBI100BxCXMSecc1SOYOBlsOyamB9211fdhHfJvli52AAMRWZVi9qeIp8IMfeIp
         q8utDKVUkif57NvjN/kSWR/Exw00dW1WVjg+q0h/Mnk9Y/0vjQPMDNJ7tEYtiq+/fcNU
         pWcZl9vojqAZViWlco3NDNw8wlJUNc6RJaY+y9cSwyZ9ZJacoInn11E5asgrbTRBqz36
         KF9Q==
X-Gm-Message-State: APjAAAVJAFqowfLWHWrgvwxYA3LaxiQrJCCbpsCWtaRFNeTm1da0DcqH
        UumUKpeCJalmHJ1TMu+NpDA=
X-Google-Smtp-Source: APXvYqxPMMiHlWFZwSS5rM0sxEQJzouyr//JBs6IBwyeuIYvbkKF3lHeFOsExNeUuWAhtyOYH4XkUQ==
X-Received: by 2002:a1c:7907:: with SMTP id l7mr5024508wme.37.1581693200934;
        Fri, 14 Feb 2020 07:13:20 -0800 (PST)
Received: from localhost (ip-37-188-133-87.eurotel.cz. [37.188.133.87])
        by smtp.gmail.com with ESMTPSA id x21sm7205302wmi.30.2020.02.14.07.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 07:13:19 -0800 (PST)
Date:   Fri, 14 Feb 2020 16:13:18 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 3/3] mm: memcontrol: recursive memory.low protection
Message-ID: <20200214151318.GC31689@dhcp22.suse.cz>
References: <20200211164753.GQ10636@dhcp22.suse.cz>
 <20200212170826.GC180867@cmpxchg.org>
 <20200213074049.GA31689@dhcp22.suse.cz>
 <20200213135348.GF88887@mtj.thefacebook.com>
 <20200213154731.GE31689@dhcp22.suse.cz>
 <20200213155249.GI88887@mtj.thefacebook.com>
 <20200213163636.GH31689@dhcp22.suse.cz>
 <20200213165711.GJ88887@mtj.thefacebook.com>
 <20200214071537.GL31689@dhcp22.suse.cz>
 <20200214135728.GK88887@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214135728.GK88887@mtj.thefacebook.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 14-02-20 08:57:28, Tejun Heo wrote:
[...]

Sorry to skip over a large part of your response. The discussion in this
thread got quite fragmented already and I would really like to conclude
to something.

> > I believe I have already expressed the configurability concern elsewhere
> > in the email thread. It boils down to necessity to propagate
> > protection all the way up the hierarchy properly if you really need to
> > protect leaf cgroups that are organized without a resource control in
> > mind. Which is what systemd does.
> 
> But that doesn't work for other controllers at all. I'm having a
> difficult time imagining how making this one control mechanism work
> that way makes sense. Memory protection has to be configured together
> with IO protection to be actually effective.

Please be more specific. If the protected workload is mostly in-memory,
I do not really see how IO controller is relevant. See the example of
the DB setup I've mentioned elsewhere.

> As for cgroup hierarchy being unrelated to how controllers behave, it
> frankly reminds me of cgroup1 memcg flat hierarchy thing I'm not sure
> how that would actually work in terms of resource isolation. Also, I'm
> not sure how systemd forces such configurations and I'd think systemd
> folks would be happy to fix them if there are such problems. Is the
> point you're trying to make "because of systemd, we have to contort
> how memory controller behaves"?

No, I am just saying and as explained in reply to Johannes, there are
practical cases where the cgroup hierarchy reflects organizational
structure as well.
-- 
Michal Hocko
SUSE Labs
