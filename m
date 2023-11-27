Return-Path: <cgroups+bounces-570-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A75097FA18A
	for <lists+cgroups@lfdr.de>; Mon, 27 Nov 2023 14:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A1A2B21246
	for <lists+cgroups@lfdr.de>; Mon, 27 Nov 2023 13:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8965330644;
	Mon, 27 Nov 2023 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lpc9evsT"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D983033D;
	Mon, 27 Nov 2023 13:54:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA89C433CB;
	Mon, 27 Nov 2023 13:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701093271;
	bh=x8+axdfJnWcUTrYe+z6TxMAlJf7WBymVwQzRmWFuviE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lpc9evsTNarsDVwG4URGVbx2z9JD2xuyvsua8/jM3OgZTRRjECZeoefY/rz77RNH8
	 tVkw8sFInsRrwrs6uIx4TohZExMunko97zDk3OXyb/DvUxGLQRu93OutVCak6vFsoa
	 afSruwfshNiGdQSdoAY5WOCtrpInZob9S5FGS6Tc=
Date: Mon, 27 Nov 2023 13:43:57 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kees Cook <keescook@chromium.org>
Cc: Tejun Heo <tj@kernel.org>, Azeem Shaikh <azeemshaikh38@gmail.com>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Waiman Long <longman@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/3] kernfs: Convert from strlcpy() to strscpy()
Message-ID: <2023112751-cozy-dangle-3f5a@gregkh>
References: <20231116191718.work.246-kees@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116191718.work.246-kees@kernel.org>

On Thu, Nov 16, 2023 at 11:21:22AM -0800, Kees Cook wrote:
> Hi,
> 
> One of the last users of strlcpy() is kernfs, which has some complex
> calling hierarchies that needed to be carefully examined. This series
> refactors the strlcpy() calls into strscpy() calls, and bubbles up all
> changes in return value checking for callers.

Why not work instead to convert kernfs (and by proxy cgroups) to use the
"safe" string functions based on seq_file?  This should be a simpler
patch series to review, and implement on a per-function basis, and then
we would not have any string functions in kernfs anymore.

thanks,

greg k-h

