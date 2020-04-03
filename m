Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2C4819DA6B
	for <lists+cgroups@lfdr.de>; Fri,  3 Apr 2020 17:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390939AbgDCPns (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Apr 2020 11:43:48 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:46455 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390855AbgDCPnr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Apr 2020 11:43:47 -0400
Received: by mail-qv1-f65.google.com with SMTP id bu9so3758453qvb.13;
        Fri, 03 Apr 2020 08:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vMx0MOLe0yvwgWuw4zcBKaQIRZC+xinekU6xHhikY6Y=;
        b=lLOBh+umo7XmD7bXXEWTjIKbErh0pNJ4W1cHP9XwA6Q/F75wkb7gFTSXpXMNV294+M
         Vwr/9u9w4YVoFzulwd8BEeyHuQ8kMIAMYrQMPKTMpXaKlFHkDZ7Hm6YJ8zGjpJfpBeWL
         sm2CLEazw1xhEEJ1vv6N8KbYOmwQOSaJC/xpscVDIULWN8lfy96+Lbuu1iGvXIB7CrA3
         lpiCY9kilSUJfP2kaS6kk+z8oXKGdFjTV1CKWpCAiQA1VZhzReL4UpiC1v3jI87qOqPs
         yrxm6+S6HCShyMOPfFjuldMpPZEjW7L+qVrB9nPI28ZkTo3OsMtNIscZjXfcVE3mJEL3
         X3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=vMx0MOLe0yvwgWuw4zcBKaQIRZC+xinekU6xHhikY6Y=;
        b=qV/GUIKYVKfj7nlDuzySxHt+Fjm4ylXvdoe1iKIgSlDIwo+41/vhHZ6LZltg3MW8Hf
         BspQENCuNlKgX4E0BnJC5R4v8BMySKf3DgMxf8ElIF1CR2+1fxi+2BIGJp4vEsYzI+vp
         XLa/bJ9RwsrOWCTV2tCN2HfiJALfrZudTqD789TwZutKPkBsZfQi2+yXJ30kyGnF3h76
         e57594aTv0NP9xsUF6B6gMcOxWktHURPnKuo3gnV991+GF3b8oSx2K8ridJazQ1gu3DX
         xD9ZbBM7AjrXewostx/sLbLvkauBO1NO/Fisb8Ah2L0Khn4229ZbKhQheXwsWfDwbyKg
         /WgA==
X-Gm-Message-State: AGi0PuZKbbdYJ4J2ddiJVB4tUpXb4wqo1G6qHtxJKzY01S6+m0InDROp
        UHtvXV+SVx/Y8i7i55g2LOE=
X-Google-Smtp-Source: APiQypIeff9mC0Z8KwgZIq+VCvmh+aODX/pV4cZ2GmTHwocSkeR+JEjsvr4Xe264cWIuYEWkSFG7RA==
X-Received: by 2002:a0c:8525:: with SMTP id n34mr8885540qva.224.1585928625897;
        Fri, 03 Apr 2020 08:43:45 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::842b])
        by smtp.gmail.com with ESMTPSA id d22sm7022682qte.93.2020.04.03.08.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 08:43:45 -0700 (PDT)
Date:   Fri, 3 Apr 2020 11:43:43 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Sonny Rao <sonnyrao@google.com>
Subject: Re: [PATCH v2] docs: cgroup-v1: Document the cpuset_v2_mode mount
 option
Message-ID: <20200403154343.GE162390@mtj.duckdns.org>
References: <20200330140615.25549-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330140615.25549-1-longman@redhat.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Mar 30, 2020 at 10:06:15AM -0400, Waiman Long wrote:
> The cpuset in cgroup v1 accepts a special "cpuset_v2_mode" mount
> option that make cpuset.cpus and cpuset.mems behave more like those in
> cgroup v2.  Document it to make other people more aware of this feature
> that can be useful in some circumstances.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-5.7.

Thanks.

-- 
tejun
