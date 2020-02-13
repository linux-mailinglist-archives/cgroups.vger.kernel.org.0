Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D47515BFC9
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2020 14:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbgBMNxv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Feb 2020 08:53:51 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46414 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729961AbgBMNxv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Feb 2020 08:53:51 -0500
Received: by mail-qk1-f195.google.com with SMTP id u124so5170555qkh.13;
        Thu, 13 Feb 2020 05:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NlK/bjEFsXh3ZUaRYaJXsg13O7KnRNlLmTitoPpLaEE=;
        b=RD/t0DYRkjg2v0l7LbvA1SM3AhbagXxt34WCWdJhaFpgAzoMY6e+khjk2cwPGiR10D
         aTFgnm5hT+CUSE4PuyoIcbZGiMBw7krH7p2VHybmp6fcs7owpHIAifcL7TuNJ1HKRXNH
         0wZN68Y99o9IJh+nKtSLFVurRhV/pla+3AZxXyAwMq6ifvSw/w33GOVWIBjgAGEbr+cx
         ttic9M1HePVTJBn7XEeY5P/9nk5eQpVDFRNKpwB0ueYpnmBijtIECdbY+eawzmMM0vme
         CwWnXscLtVr9I9yGj29HLPTB2lhjTczuCOTtgZ9WbuCCtFU3F43OwD6ecTUG9Gnqom/i
         ieVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=NlK/bjEFsXh3ZUaRYaJXsg13O7KnRNlLmTitoPpLaEE=;
        b=ddwOC8BVavi9p/Pt0rcjyMB584tpehSyLZksiOt+io0w9HC0lcLJgr6e10EHgFIngl
         KOxLiEoW1HJmdKAfsXLOIPmGuH6USbv7C7yuTJ6YHgg/P2XAgahgzZj7pt4ZvHV4XjAz
         3jwUhURuWXCvH4q47x3KUXVx9Xsvqox3wV/C1r/KAVsfpMphIsopcOu1O8LibVeNVtn5
         iSKIicDhGr7locqC1zyK7jqJrGgck/TKkm4t2nfgtnqwMcrIoHR0g3u9MQoaTxenRb/4
         Syt2qhhjaYRFaumsPL1fawmQUcxrKUPZ13ZdOanuS3jhO0fU7jZc0MDZTqjhwcrkoYsa
         L5Xw==
X-Gm-Message-State: APjAAAWxq5GhGkKPdaBX8J7AUc4ddxX0GXlx8FvDP9iBVKSwvJrD9Ggj
        IeVj2f3UhOchvB6XllggiLM=
X-Google-Smtp-Source: APXvYqz5u80waaYGchbdKXvEMTIeavCdnxOzKq9fHUfxpwnBb49hqgHwLX5XvMlBjyEKhebBD7m2yw==
X-Received: by 2002:a37:dd8:: with SMTP id 207mr15467412qkn.292.1581602029790;
        Thu, 13 Feb 2020 05:53:49 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:f3be])
        by smtp.gmail.com with ESMTPSA id p26sm1309845qkp.34.2020.02.13.05.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 05:53:49 -0800 (PST)
Date:   Thu, 13 Feb 2020 08:53:48 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 3/3] mm: memcontrol: recursive memory.low protection
Message-ID: <20200213135348.GF88887@mtj.thefacebook.com>
References: <20191219200718.15696-1-hannes@cmpxchg.org>
 <20191219200718.15696-4-hannes@cmpxchg.org>
 <20200130170020.GZ24244@dhcp22.suse.cz>
 <20200203215201.GD6380@cmpxchg.org>
 <20200211164753.GQ10636@dhcp22.suse.cz>
 <20200212170826.GC180867@cmpxchg.org>
 <20200213074049.GA31689@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213074049.GA31689@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Michal.

On Thu, Feb 13, 2020 at 08:40:49AM +0100, Michal Hocko wrote:
> So how are we going to deal with hierarchies where the actual workload
> of interest is a leaf deeper in the hierarchy and the upper levels of
> the hierarchy are shared between unrelated workloads?  Look at how
> systemd organizes system into cgroups for example (slices vs. scopes)
> and say you want to add a protection to a single user or a service.

The above scenario where descendants of a cgroup behave unrelated to
each other sound plausible in theory but doesn't really work in
practice because memory management is closely tied with IO and all IO
control mechanisms are strictly hierarchical and arbitrate
level-by-level.

A workload's memory footprint can't be protected without protecting
its IOs and a descendant cgroup's IOs can't be protected without
protecting its ancestors, so implementing that in memory controller in
isolation, while doable, won't serve many practical purposes. It just
ends up creating cgroups which are punished on memory while greedly
burning up IOs.

The same pattern for CPU control, so for any practical configuration,
the hierarchy layout has to follow the resource distribution hierarchy
of the system - it's what the whole thing is for after all. The
existing memory.min/low semantics is mostly from failing to recognize
them being closely intertwined with IO and resembling weight based
control mechanisms, and rather blindly copying memory.high/max
behaviors, for which, btw, individual configurations may make sense.

Thanks.

-- 
tejun
