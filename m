Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 696D2126EC3
	for <lists+cgroups@lfdr.de>; Thu, 19 Dec 2019 21:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfLSUWX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 Dec 2019 15:22:23 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35366 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfLSUWP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 Dec 2019 15:22:15 -0500
Received: by mail-qk1-f196.google.com with SMTP id z76so6102562qka.2;
        Thu, 19 Dec 2019 12:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r3E/D07/ZPDWwCmYCAV3wbix4nrV2NEeuAgSXWyKjuk=;
        b=u6Wv8j6rmYawNkXdt1PMu7j72pvZx7svOC3E6pznjHc7+FKrdLbnpmSkSLwC619uwG
         SIgEtVQR3RNyDP+MnUu66RibgcVwqQX/7rUtScjLHr6Pal8yn5U7QlcAesErCFSx45hg
         onib1uCCGQGQadOVJ+9ENHyQPk7xutFYx7b1zOF5X0rBodDabJl+LlsmlqIuIykD/DzO
         MOmBK1o41B4picUTKElrG4ixXSjCjS7NnbUTWFBfd3+qZfRpJHnl1AFp7qvXMZxle2rU
         17vEUZKBjvL3LIfCGY1R9UbjtXkIr9KX9urMGHHKJB+HfnE4pxaih6aOzIYdxGCeXAuG
         GRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=r3E/D07/ZPDWwCmYCAV3wbix4nrV2NEeuAgSXWyKjuk=;
        b=rwEoMk+gS2ANdTYlTeJspJ1zHZzEZEelPLOfki4YOSjl2m7PdrNSu+mf/9cA0hcocC
         vBzoRqVcO+uiBOdq2GCJsHdXnkQEq5zZckJmvxSCD7oN2C6sNtZkucM0eteHz2XEtm/g
         i5rD2ds41uUxEOET5++IXylw+GPQ/4pWdOP12CvPVCKDXf456rRHIZMGbqKl0g33kQUT
         QvQba+swYiPSN5uH6G42HgbKt0EsBT6rus3NS7a/Yl9p+8Sh2xXktKKXU7OByZFR+STd
         SM65c1hu4xuD8977V8K+HGrW2DQV1lA3N1w7Qh6dEEFFbxPDuKkL3TM1RVKXD1+xg6Q5
         NbNw==
X-Gm-Message-State: APjAAAV0k/hE9goMpZVZaqYFxMCGSy+tlCfD9IQ8rh4tCSFrOqE9iWVP
        D75yvgibXqwUc6GS4cLRqwHJFCGVzNI=
X-Google-Smtp-Source: APXvYqwjzlfu4HM0DKELI9BComNmyS8fALsw5Qp8Q5/Hv7wFJLwaM5FyiCgJ4C2p0Cv1SU6/gb4l9w==
X-Received: by 2002:a37:de05:: with SMTP id h5mr10251127qkj.474.1576786934078;
        Thu, 19 Dec 2019 12:22:14 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:29ea])
        by smtp.gmail.com with ESMTPSA id z28sm2280778qtz.69.2019.12.19.12.22.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 12:22:13 -0800 (PST)
Date:   Thu, 19 Dec 2019 12:22:11 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 0/3] mm: memcontrol: recursive memory protection
Message-ID: <20191219202211.GD2914998@devbig004.ftw2.facebook.com>
References: <20191219200718.15696-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219200718.15696-1-hannes@cmpxchg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Dec 19, 2019 at 03:07:15PM -0500, Johannes Weiner wrote:
> Changes since v1:
> - improved Changelogs based on the discussion with Roman. Thanks!
> - fix div0 when recursive & fixed protection is combined
> - fix an unused compiler warning
> 
> The current memory.low (and memory.min) semantics require protection
> to be assigned to a cgroup in an untinterrupted chain from the
> top-level cgroup all the way to the leaf.
> 
> In practice, we want to protect entire cgroup subtrees from each other
> (system management software vs. workload), but we would like the VM to
> balance memory optimally *within* each subtree, without having to make
> explicit weight allocations among individual components. The current
> semantics make that impossible.

Acked-by: Tejun Heo <tj@kernel.org>

The original behavior turned out to be a significant source of
mistakes and use cases which would require older behavior just weren't
there.

Thanks.

-- 
tejun
