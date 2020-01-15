Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85E1C13C8CA
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2020 17:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgAOQHu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Jan 2020 11:07:50 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38866 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbgAOQHt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Jan 2020 11:07:49 -0500
Received: by mail-qt1-f195.google.com with SMTP id c24so5413327qtp.5;
        Wed, 15 Jan 2020 08:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zSIfSAzXaUnmeHj5yAo3f8W68OERKqDK+WA3I8DQXME=;
        b=djnWz5Uv5uxqmn8ZPz8gXmpXymRwdVRfn2Ka203Vjcor3GCoGHr4bsAzTivzjFgh6U
         qt/PLBVgXNj39rkovMYAxr5MF2wYd7D1+Yjilxz02n8uXjasXFbCy4q2YPMX0PGg9Q7v
         AFifPDmKFtqeQ5zKZkysF5IAlIlXIeTd/hR03AhLB7eM7sj1erDyBl6wQXZRkYGb04Qc
         bbJD7lp2zBvZqlWNllNjM1DJCYEHr14B0QQmorF72OTclYQWbKGU8GwceQF01uoCFeuJ
         PyGvhCAJEeDDu1VnZ2Dtc4Q53lNCP8LEMHDLfgq8EWFk/DBWB8cK2hTbyI/Ixct35Pyg
         iNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=zSIfSAzXaUnmeHj5yAo3f8W68OERKqDK+WA3I8DQXME=;
        b=iZexNFORkrGNHZSx8DbOh33CUdI2LntyDKfUrL9hF6PpI2L2ZlOo7XBDmbAnxhhGaw
         gpV0xL6uUWZBfBmVzUaYvq4huXBfubTmcN6M5U/KOemrMzCvpIqxOuBxmgJf/BerViPZ
         yLeUUYdMxniOOllQl/Je6dLi9d6OwJ/yewWHqEm3qz36cexI8MnDAX/8GkjCT2S2meN0
         bomCX5/IZgYraY/Au5kgoeUhab7ihlIqkeuLsZ/Fjqp+8VVhyBQ71obn5OBMFg2b3UP6
         IsfxsZXiGr5VP1FlbaWKkw+lebxmTj7PFl0tTd9OXpHq89/omDtMT6qKCyIgC1xxcqqm
         lsgw==
X-Gm-Message-State: APjAAAVoMIs84YHDIyoPrIiu8P5+GKbmu2D08dPIjrpU8IYih9TV2KEB
        RkuNAAgl35RpyeF3zlOPMAouwsNYwao=
X-Google-Smtp-Source: APXvYqwaOY/q4re19MhwRUa9NQCI8Rv79UWbxsm5d1zjBr1b8VHAGwijlXdLYJlD+sB8r6wQNbmHqA==
X-Received: by 2002:ac8:3510:: with SMTP id y16mr4288551qtb.6.1579104468267;
        Wed, 15 Jan 2020 08:07:48 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:1e68])
        by smtp.gmail.com with ESMTPSA id n4sm9344056qti.55.2020.01.15.08.07.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jan 2020 08:07:47 -0800 (PST)
Date:   Wed, 15 Jan 2020 08:07:46 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH] cgroup: Prevent double killing of css when enabling
 threaded cgroup
Message-ID: <20200115160746.GG2677547@devbig004.ftw2.facebook.com>
References: <20191219022716.o7vxxia6o67tyfmf@wittgenstein>
 <20200109150559.14457-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200109150559.14457-1-mkoutny@suse.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jan 09, 2020 at 04:05:59PM +0100, Michal Koutný wrote:
> The commit prevents these situations by making cgroup_type_write wait
> for all dying csses to go away before re-applying subtree controls.
> When at it, the locations of WARN_ON_ONCE calls are moved so that
> warning is triggered only when we are about to misuse the dying css.

Applied to cgroup/for-5.6.

Thanks.

-- 
tejun
