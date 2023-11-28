Return-Path: <cgroups+bounces-601-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E957FBF63
	for <lists+cgroups@lfdr.de>; Tue, 28 Nov 2023 17:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6CFC1C20D7C
	for <lists+cgroups@lfdr.de>; Tue, 28 Nov 2023 16:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2916B4D5AD;
	Tue, 28 Nov 2023 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Knq0k55b"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DBBD6;
	Tue, 28 Nov 2023 08:43:41 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cf8e569c35so37395465ad.0;
        Tue, 28 Nov 2023 08:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701189821; x=1701794621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t1G9rYIEZ34mJXbbwuA3/PHTXFDOWuxrzGTb7P8Akig=;
        b=Knq0k55bN+diKYC8OTzPLGcLkogD7/+w3N+s1CQTqx23Amwx3SmaaIE2QosSSqZRr+
         951Q0y7gTQwMR+CsJG2rinb+js3gDzDLkVozFAu1ediF8JJVJqifwHyrzQcHlW9fImks
         YCbvXv7gDQnEHk4e5pRHnYtz8JeKnYoco6lALft/Ft47XmDKsUrHOvWYCuruBMXtFp7k
         5x16746SqkUrhjaYpuhRWZPcqwLKWhTcP4xYQa8W8AVYaEF/CKCdgoaIBE2TjLlgroHu
         BYdKm7c28ElmbkCMy6L8+VydJ0ICaqNY2kKc/gmGObGq3v45tiuzyV3sVt2NICtEZKL4
         OGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701189821; x=1701794621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1G9rYIEZ34mJXbbwuA3/PHTXFDOWuxrzGTb7P8Akig=;
        b=LBUvmr4mJTVa51uyitvov/AYNA6whXTakK4T4n533lMj2S+ETyR5GCInSnLK7XHX/f
         JWdzEincfyKP+XbqTTvJ5BjDLEoARgagq3ttj6lie8p5aFcQ/Tgoz6L+FW0PHtSojMdY
         c3IUTguz5BZlhlzQ4k8rYI0WKXhZNgT3mhSZUbDD5thF7Fdb8GbgQWcXqNqIetUSU3GV
         /csFr2uJik6+9U6Ih+dR+lBBzaYWDVNUM2iZCp7zoM+I5bouEXK/OA4SZ3bO0jCBkGMd
         6vrsA95Zjoz0xFXEm0tY+QgddP+U4Dc8lUfJSME00fqB+pn+Us3LrNumu7ijNj6jefuY
         b48A==
X-Gm-Message-State: AOJu0YwC+TKSqTdppFmVA0sF3DVihfTnD8MtXEC7gRZrw1wjJgwJLCPL
	IN1L6S8P49l7ygOtNI/9Ot8=
X-Google-Smtp-Source: AGHT+IGaOXiY5snwKYq8K0A1rJzX5WiJvhSjBS9hO5FOrASiq5XeF3YfPC//rHJ44BHfXGJa51RGUA==
X-Received: by 2002:a17:902:c10d:b0:1cf:cd2d:e296 with SMTP id 13-20020a170902c10d00b001cfcd2de296mr6915216pli.37.1701189820925;
        Tue, 28 Nov 2023 08:43:40 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902c1c600b001cfd0ed1604sm3930815plc.87.2023.11.28.08.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 08:43:40 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 28 Nov 2023 06:43:38 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joe Mario <jmario@redhat.com>,
	Sebastian Jug <sejug@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH v4 2/3] cgroup/rstat: Optimize cgroup_rstat_updated_list()
Message-ID: <ZWYYrJVMUOrl9r2g@slm.duckdns.org>
References: <20231106210543.717486-1-longman@redhat.com>
 <20231106210543.717486-3-longman@redhat.com>
 <a9aa2809-95f5-4f60-b936-0d857c971fea@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9aa2809-95f5-4f60-b936-0d857c971fea@redhat.com>

On Mon, Nov 27, 2023 at 11:01:22PM -0500, Waiman Long wrote:
...
> > + * Recursively traverse down the cgroup_rstat_cpu updated tree and push
> > + * parent first before its children into a singly linked list built from
> > + * the tail backward like "pushing" cgroups into a stack. The parent is
> > + * pushed by the caller. The recursion depth is the depth of the current
> > + * updated subtree.
> > + */
> > +static struct cgroup *cgroup_rstat_push_children(struct cgroup *head,
> > +				struct cgroup_rstat_cpu *prstatc, int cpu)
> > +{
> > +	struct cgroup *child, *parent;
> > +	struct cgroup_rstat_cpu *crstatc;
> > +
> > +	parent = head;
> > +	child = prstatc->updated_children;
> > +	prstatc->updated_children = parent;
> > +
> > +	/* updated_next is parent cgroup terminated */
> > +	while (child != parent) {
> > +		child->rstat_flush_next = head;
> > +		head = child;
> > +		crstatc = cgroup_rstat_cpu(child, cpu);
> > +		if (crstatc->updated_children != child)
> > +			head = cgroup_rstat_push_children(head, crstatc, cpu);
> > +		child = crstatc->updated_next;
> > +		crstatc->updated_next = NULL;
> > +	}
> > +	return head;

The recursion bothers me. We don't really have a hard limit on nesting
depth. We might need to add another pointer field but can make this
iterative, right?

Thanks.

-- 
tejun

