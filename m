Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44F2F10A4F6
	for <lists+cgroups@lfdr.de>; Tue, 26 Nov 2019 20:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbfKZT7M (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Nov 2019 14:59:12 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:45197 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfKZT7M (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Nov 2019 14:59:12 -0500
Received: by mail-qv1-f68.google.com with SMTP id c2so674107qvp.12
        for <cgroups@vger.kernel.org>; Tue, 26 Nov 2019 11:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zVETl4dSb5XRkmBzWNGJmPzMALvRObaixf1eO1AVqG8=;
        b=AuGmLFHyqCCiN+wMOcPOF67cZTeHxCCp+zYdSKvtDSlsUlik6arKMPZjpKMQWCJ/N8
         zR3ZtWAdngjkom0cRSgQIr4veElqIekMylfFymrBW57SXRK3gLLPacK24L0Z287wtDTw
         LdInQgUyYqDyoh2J0GwUzWdLstu/BmgsP1ogoWGDrHlpg75ao00dK84eRn0UflFNIxd6
         RjE1Yurs/IfxeqULoOLtTfbZvNTKaqR0MpnBoTQMnf74DQQtXAZYBwEBWkeA+1SVJ9Zq
         cSzbTMvZlXGzj0wXH8ifeFUKfLNkjBs4nDCSOseUHCf7j/a43wrG602RiCbFSgd52GW9
         kSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zVETl4dSb5XRkmBzWNGJmPzMALvRObaixf1eO1AVqG8=;
        b=EDLJBFhqTHczaTfA62TZKG21fKaM1KX8iNS9imBpczkp2bSPf0e8DEb9F7fl1HbS5W
         C2uV3eJcOuEoTFalSzOCs+i8uk2Q2oiXpMrV7aneiDo8vB/8FZKY5nqOLhygl9w8Fh6D
         tX1jZ7ZVJO72ECPe5kYuApBWlbzySsO4ZYjcX4tQotuF8U677Sloki6Tsj0qehzkNLrW
         B6jMGlne/Tnsjm7+epxBI+CzeF0qyj+gGh6S/t1VHPscg409H6aC0fhtwT4q/9yp6Mso
         cuXJnmVwerpejOjobuvp9ARshvMt1sU+hhqBop9sO/qWXEQQYGJKfrBqXBiQCoDEP9uR
         BTwA==
X-Gm-Message-State: APjAAAUPmZJ0M5DV8RVy3PzuQmxziTeTwv8Q8Eule0tC+CpyizOokPGy
        EUuZxnwEtB0IKQn5Nv4iCsZ2Vsfm
X-Google-Smtp-Source: APXvYqytgcjDoVaSzAU3cdwigN2OJPebgcfQdxVeBr+MHfEPxlyIuhk3Bgm9LSp82eE/jxlTYSlcdg==
X-Received: by 2002:a0c:b288:: with SMTP id r8mr549267qve.42.1574798350726;
        Tue, 26 Nov 2019 11:59:10 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:a515])
        by smtp.gmail.com with ESMTPSA id l14sm5621032qkj.61.2019.11.26.11.59.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Nov 2019 11:59:10 -0800 (PST)
Date:   Tue, 26 Nov 2019 11:59:08 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     cgroups@vger.kernel.org, mike.kravetz@oracle.com,
        lizefan@huawei.com, hannes@cmpxchg.org, almasrymina@google.com
Subject: Re: [PATCH v2] mm: hugetlb controller for cgroups v2
Message-ID: <20191126195908.GA16681@devbig004.ftw2.facebook.com>
References: <20191126195600.1453143-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126195600.1453143-1-gscrivan@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Nov 26, 2019 at 08:56:00PM +0100, Giuseppe Scrivano wrote:
> In the effort of supporting cgroups v2 into Kubernetes, I stumped on
> the lack of the hugetlb controller.
> 
> When the controller is enabled, it exposes three new files for each
> hugetlb size on non-root cgroups:
> 
> - hugetlb.<hugepagesize>.current
> - hugetlb.<hugepagesize>.max
> - hugetlb.<hugepagesize>.events
> 
> The differences with the legacy hierarchy are in the file names and
> using the value "max" instead of "-1" to disable a limit.
> 
> The file .limit_in_bytes is renamed to .max.
> 
> The file .usage_in_bytes is renamed to .usage.
> 
> .failcnt is not provided as a single file anymore, but its value can
> be read in the new flat-keyed file .events, through the "max" key.

Looks great.  Just one more thin.  The .events are expected to
generate file changed event when something changes inside so that
userspace can poll for it.  Can you please implement that for hugetlb
too?

Thanks.

-- 
tejun
