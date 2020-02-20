Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85E3616690A
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2020 21:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgBTUyU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Feb 2020 15:54:20 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43304 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgBTUyU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Feb 2020 15:54:20 -0500
Received: by mail-qt1-f193.google.com with SMTP id g21so3913620qtq.10;
        Thu, 20 Feb 2020 12:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BiE+rct0rry2pArV3gigMdzlZiS1+memMy+VBdXCC0g=;
        b=oHWDw6RCZdv06TZrh3Qj3gsEIXivcxE3uXPCbkcJ2m2UdQNHxxKuovATMPLuouJjWG
         /7xptXQ03FED86Sla82047upyBEwI7HZBrTJXMer3p1NaCTwIpl16i4cOA7FPSFwwncS
         RUIp1/jottGogriZOzdHOi3HyT61dDWUWxDebE8ZiGPJ2NkCjmgm+shlmh5wd83Qzy3Z
         30286SGALzQD8SzVxnEet57ytjDAmy8YcnYLI48M4clrruxKdKnmO6MIgs507n5itrye
         6TpiJZ0fBNrb2OL9NGL+NJLlTWEAMfP3nSPcOxps//7VAMRGHfh2t/E95u0WyPTdwj5R
         ChBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=BiE+rct0rry2pArV3gigMdzlZiS1+memMy+VBdXCC0g=;
        b=Q7KXVyVHwypRtv42tH2ru772XVRri88IxIn7uIHPpYUKHUnDNybvquoP3iQIN4jszQ
         +CYYc7GSXncDupngtB6jHugNG1+/zWkTV5qZxvMzks145KBexzHUHqWLcOr3iHg2H33x
         khXLL7p6yviQLBR9ZKU7V6lBGsH8BlY/xmgBky6q0CnegFexeVsyxdK9+N8e5QOYUrCT
         ByZ9Cc3yrw5fEGzDRHc9xOObqgqukmX3KxGIaRhJYnH+o5sbpU8OVkmaU4Coqy7QgdPW
         DN9l3Une9E5cjLYykJuXxYJroSQ0lRPLjWs19n+oLekA6BEbFSQVRhFf/DUItUVCxyMg
         QE2g==
X-Gm-Message-State: APjAAAXVYdhXARrzBr8LOe1Rof32SYngJn9G+bvvmOiQhrL26bpmV88A
        DlbzDtoE7ngLOrU0kf3ISsA=
X-Google-Smtp-Source: APXvYqx8p0C/GaJD7Fie8OUeewsrbm4Q0PH7AogGZxTkl86op5vkJ3JFVQfhBK9/2ANYRUN8ev8xbA==
X-Received: by 2002:aed:3f70:: with SMTP id q45mr27822085qtf.310.1582232057881;
        Thu, 20 Feb 2020 12:54:17 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::55b1])
        by smtp.gmail.com with ESMTPSA id g9sm420153qkl.11.2020.02.20.12.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 12:54:17 -0800 (PST)
Date:   Thu, 20 Feb 2020 15:54:16 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] mm: memcontrol: asynchronous reclaim for memory.high
Message-ID: <20200220205416.GI698990@mtj.thefacebook.com>
References: <20200219183731.GC11847@dhcp22.suse.cz>
 <20200219191618.GB54486@cmpxchg.org>
 <20200219195332.GE11847@dhcp22.suse.cz>
 <20200219214112.4kt573kyzbvmbvn3@ca-dmjordan1.us.oracle.com>
 <20200219220859.GF54486@cmpxchg.org>
 <20200220154524.dql3i5brnjjwecft@ca-dmjordan1.us.oracle.com>
 <20200220155651.GG698990@mtj.thefacebook.com>
 <20200220182326.ubcjycaubgykiy6e@ca-dmjordan1.us.oracle.com>
 <20200220184545.GH698990@mtj.thefacebook.com>
 <20200220195535.7xblt45akld6eftj@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220195535.7xblt45akld6eftj@ca-dmjordan1.us.oracle.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Daniel.

On Thu, Feb 20, 2020 at 02:55:35PM -0500, Daniel Jordan wrote:
> On Thu, Feb 20, 2020 at 01:45:45PM -0500, Tejun Heo wrote:
> > The setup cost can be lazy optimized but it'd still have to bounce the
> > tiny pieces of work to different threads instead of processing them in
> > one fell swoop from the same context, which most likely is gonna be
> > untenably expensive.
> 
> I see, your last mail is clearer now.  If it's easy to do, a pointer to where
> this happens would help so we're on the same page.

Network packet rx is the clearest example I think, but you already
mentioned it. Reclaim is less so but when kswapd reclaims, it walks
everybody, and there can be a lot of small cgroups.

Thanks.

-- 
tejun
