Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAD71A3969
	for <lists+cgroups@lfdr.de>; Thu,  9 Apr 2020 19:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDIR4t (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Apr 2020 13:56:49 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:37490 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDIR4s (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Apr 2020 13:56:48 -0400
Received: by mail-wm1-f54.google.com with SMTP id z6so660669wml.2
        for <cgroups@vger.kernel.org>; Thu, 09 Apr 2020 10:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RE3VHE0rvREJWCVJmNBX2NQs76M9qqKu6sqBlBeuyf4=;
        b=BtsXpXg+oW5k/lZe16X3+KqOuDsPyI7Qm6wWMejyMZQuO/VQYg+545plGEu1Cc1V25
         GZNWzHCYU3sVNveqreKBmg8RIAMWW17b4w4QjsF25Zajw3P/0myBLGQaKzocj83iDYfQ
         pQuDN4LU0guMN2eu2NxN0YceZOeQ8Q9sufPYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RE3VHE0rvREJWCVJmNBX2NQs76M9qqKu6sqBlBeuyf4=;
        b=XA19+scrYO+jeZBzuQYon6IZ9qzpwigJOjz83h8vyR8cNpuqvnH9e/I+e6833W7xar
         dcnSGYtL2JnG0qOrbsyOmLSovS/vwFhjGiUwoJf++kIjCzPS25LJogO31QF7bOkTk9XD
         VvX18T5YxeNfjQUVVWO+4sw5X5ijMLk8I5kBx2Sbv8E6dgjXGutixZpewEkOj0U89jnG
         nBOX5dfx6asJyJrOxW+cw1sGOwRxzS5AeRk8BjLO+m2KfF6gAlr+JGnikZuniQFHgz86
         CX3MqClb0M4OCVDiiuyxEt7FUeE6+OlHmIq9FKMEWayW+/wgc6kQdb3HY0iYbai/qxW3
         x9ig==
X-Gm-Message-State: AGi0PuYDWZ7lL3TC7qaOAOj5OfhYcKkZkAvHuzRkbGlkYbLBG99VdjiM
        nJzhU2znDlGpIlpG4qhq5UT1vg==
X-Google-Smtp-Source: APiQypJVtJjnh4GpoLFWOVI8MNs/ogBJoEpqIUzzkJxRdXxH49inFhFbvBInfgo+rfxOsOpJ46n3Nw==
X-Received: by 2002:a05:600c:2284:: with SMTP id 4mr995515wmf.103.1586455007180;
        Thu, 09 Apr 2020 10:56:47 -0700 (PDT)
Received: from localhost ([2620:10d:c092:180::1:9ebe])
        by smtp.gmail.com with ESMTPSA id s6sm4565956wmh.17.2020.04.09.10.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 10:56:46 -0700 (PDT)
Date:   Thu, 9 Apr 2020 18:56:46 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc:     Michal Hocko <mhocko@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: Memory CG and 5.1 to 5.6 uprade slows backup
Message-ID: <20200409175646.GD1040020@chrisdown.name>
References: <20200409112505.2e1fc150@hemera.lan.sysophe.eu>
 <20200409094615.GE18386@dhcp22.suse.cz>
 <20200409121733.1a5ba17c@hemera.lan.sysophe.eu>
 <20200409103400.GF18386@dhcp22.suse.cz>
 <20200409170926.182354c3@hemera.lan.sysophe.eu>
 <20200409152417.GB1040020@chrisdown.name>
 <20200409174042.2a3389ba@hemera.lan.sysophe.eu>
 <20200409175044.GC1040020@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200409175044.GC1040020@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

 From my side, this looks like memory.high is working as intended and there is 
some other generic problem with reclaim happening here.

I think the data which Michal asked for would help a lot to narrow down what's 
going on.
